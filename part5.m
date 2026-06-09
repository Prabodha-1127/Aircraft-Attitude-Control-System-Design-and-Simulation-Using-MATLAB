%2022e116
%Heuristically tune the controller

clc; clear;

a = 9; b = 0.7224; K = 0.1;
G = tf([a*K], [1 b 0]);

% Store tuning stages
stages = {
    struct('Kp', 1.0, 'Ki', 0, 'Kd', 0.0, 'Label', 'P-only')
    struct('Kp', 1.5, 'Ki', 0.0, 'Kd',2.5 , 'Label', 'PD')
    struct('Kp', 1.5, 'Ki', 0.08, 'Kd', 0.2, 'Label', 'PID (Optimized)')
};

for i = 1:length(stages)
    s = stages{i};
    C = pid(s.Kp, s.Ki, s.Kd);
    T = feedback(C*G, 1);

    fprintf('\n--- %s ---\n', s.Label);
    info = stepinfo(T);
    fprintf('Rise Time: %.2f s | Overshoot: %.2f%% | Settling Time: %.2f s\n', ...
        info.RiseTime, info.Overshoot, info.SettlingTime);

    [GM, PM, Wcg, Wcp] = margin(C*G);
    fprintf('GM: %.2f dB | PM: %.2f deg | Wcg: %.2f rad/s\n', ...
        20*log10(GM), PM, Wcg);

    figure;
    subplot(2,1,1);
    step(T);
    title(sprintf('Step Response - %s', s.Label));
    grid on;

    subplot(2,1,2);
    margin(C*G);
    title(sprintf('Bode Plot - %s', s.Label));
    grid on;
end
