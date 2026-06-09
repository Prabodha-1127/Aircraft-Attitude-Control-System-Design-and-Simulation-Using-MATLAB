%2022e116
% Stability Check for PID 

clc; clear;

% Plant parameters
a = 9;
b = 0.7224;
K = 0.1;

% Define open-loop plant G(s)
G = tf([a*K], [1, b, 0]);

% PID controller gains (your chosen values)
Kp = 1.5;
Ki = 0;
Kd = 2.0;

% Compute Ki max from inequality
Ki_max = (b + a*K*Kd) * Kp;

fprintf('Stability Verification \n');
fprintf('Stability condition: Ki < (b + 9K·Kd)·Kp = %.4f\n', Ki_max);
fprintf('Kp = %.2f, Kd = %.2f, Ki = %.2f\n', Kp, Kd, Ki);

if Ki > 0 && Ki < Ki_max
    fprintf('Ki is within the stable range.\n');
else
    fprintf('Ki is outside the stable range.\n');
end

% Create PID controller
C = pid(Kp, Ki, Kd);

% Closed-loop system with unity feedback
T = feedback(C * G, 1);

% Pole analysis
poles = pole(T);
if all(real(poles) < 0)
    fprintf('All poles are in the left half-plane → System is STABLE.\n\n');
else
    fprintf('System has unstable poles → UNSTABLE.\n\n');
end

% Step response
figure;
step(T);
title(sprintf('Step Response with PD Controller (Kp=%.2f, Ki=%.2f, Kd=%.2f)', Kp, Ki, Kd));
xlabel('Time (s)');
ylabel('Output');
grid on;

% Frequency response
figure;
margin(C*G);
title('Bode Plot with PD Controller');
grid on;

% Time-domain performance
info = stepinfo(T);
fprintf('Step Response Characteristics \n');
fprintf('Rise Time = %.2f s\n', info.RiseTime);
fprintf('Overshoot = %.2f %%\n', info.Overshoot);
fprintf('Settling Time = %.2f s\n', info.SettlingTime);
fprintf('Steady-State Error = %.4f\n', abs(1 - dcgain(T)));

% Frequency-domain metrics
[GM, PM, Wcg, Wcp] = margin(C*G);
fprintf('\n Frequency Domain Characteristics \n');
fprintf('Gain Margin = %.2f dB\n', 20*log10(GM));
fprintf('Phase Margin = %.2f deg\n', PM);
fprintf('Gain Crossover Freq = %.2f rad/s\n', Wcg);
fprintf('Phase Crossover Freq = %.2f rad/s\n', Wcp);

