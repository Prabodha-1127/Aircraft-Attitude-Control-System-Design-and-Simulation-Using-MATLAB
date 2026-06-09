%2022e116
% The system with the tuned PD controller 
clc; clear;

% Plant and PD controller definition
a = 9;
b = 0.7224;
K = 0.1;

G = tf([a*K], [1, b, 0]);

% Tuned PD controller (optimized values)
Kp = 9.0;
Ki = 0.0;
Kd = 8.0;

C = pid(Kp, Ki, Kd);

% Closed-loop transfer function
T = feedback(C * G, 1);

% Open-loop transfer function
L = C * G;

% Time-domain characteristics 
info = stepinfo(T);
rise_time = info.RiseTime;
overshoot = info.Overshoot;
settling_time = info.SettlingTime;
offset = abs(1 - dcgain(T));  % steady-state error

% Frequency-domain characteristics 
[GM, PM, Wcg, Wcp] = margin(L);
GM_dB = 20 * log10(GM);

% Display numeric results
fprintf('Time-Domain Performance \n');
fprintf('Rise Time          = %.2f s\n', rise_time);
fprintf('Overshoot          = %.2f %%\n', overshoot);
fprintf('Settling Time      = %.2f s\n', settling_time);
fprintf('Steady-State Error = %.4f\n', offset);

fprintf('\n Frequency-Domain Performance \n');
fprintf('Gain Margin (GM)   = %.2f dB\n', GM_dB);
fprintf('Phase Margin (PM)  = %.2f degrees\n', PM);
fprintf('Gain Crossover Freq (Wcg) = %.2f rad/s\n', Wcg);
fprintf('Phase Crossover Freq (Wcp) = %.2f rad/s\n', Wcp);

% Plot Step Response
figure;
step(T);
title('Step Response of Tuned PD-Controlled System');
xlabel('Time (s)');
ylabel('Output');
grid on;

% Plot Bode with Margin 
figure;
margin(L);
title('Bode Plot with Gain and Phase Margins');
grid on;
