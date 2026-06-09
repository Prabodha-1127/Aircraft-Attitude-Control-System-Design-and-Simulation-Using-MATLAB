%2022e116
%Verify Stability using Bode Plot Margins

clc; clear;

% Step 1: Define system and PID gains

a = 9;
b = 0.7224;
K = 0.1;

% Plant: G(s) = 9K / [s(s + b)]
G = tf([a*K], [1, b, 0]);

% PID gains (adjust as needed)
Kp = 1.5;
Ki = 0.0;
Kd = 2.0;

% PID Controller C(s)
C = pid(Kp, Ki, Kd);

% Step 2: Open-loop system L(s)

L = C * G;

% Step 3: Compute Gain Margin, Phase Margin, and crossover frequencies
[GM, PM, Wcg, Wcp] = margin(L);
GM_dB = 20 * log10(GM);  % Convert gain margin to dB

% Step 4: Display margin results

fprintf('Bode Plot Stability Verification \n');
fprintf('Gain Margin              = %.2f dB\n', GM_dB);
fprintf('Phase Margin             = %.2f degrees\n', PM);
fprintf('Gain Crossover Frequency = %.2f rad/s\n', Wcg);
fprintf('Phase Crossover Frequency= %.2f rad/s\n', Wcp);

% Step 5: Interpret the results (with all stability conditions)

fprintf('\n Stability Decision Based on Bode Margins \n');

% Define sufficiency flags
is_PM_sufficient = PM > 30;
is_GM_sufficient = GM > 1 || isinf(GM);  % Accept Inf as sufficient
is_Wcg_valid = ~isnan(Wcg) && Wcg > 0;
is_Wcp_valid = ~isnan(Wcp) && Wcp > 0;

% Decision logic
if is_PM_sufficient && is_GM_sufficient
    fprintf('STABLE: Phase margin > 30° and Gain margin is acceptable.\n');
    if is_Wcg_valid
        fprintf('   → Gain Crossover Frequency = %.2f rad/s\n', Wcg);
    else
        fprintf('   → No gain crossover (Wcg = NaN) — still stable due to large PM.\n');
    end
elseif is_PM_sufficient && ~is_GM_sufficient
    fprintf('MARGINALLY STABLE: PM > 30°, but Gain Margin is low or undefined.\n');
elseif ~is_PM_sufficient && is_GM_sufficient
    fprintf('UNSTABLE: Phase margin too low despite acceptable gain margin.\n');
else
    fprintf('UNSTABLE: Both gain and phase margins are insufficient.\n');
end

% Step 6: Plot Bode plot with annotations

[mag, phase, w] = bode(L);
mag = squeeze(mag);
phase = squeeze(phase);

figure;
margin(L);
title('Bode Plot with Gain & Phase Margins and Crossovers');
grid on;
hold on;

% Annotate Gain Margin at Gain Crossover Frequency (Wcg)
if is_Wcg_valid
    y_mag = interp1(w, 20*log10(mag), Wcg);
    plot(Wcg, y_mag, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    text(Wcg, y_mag + 5, ...
        sprintf('\\leftarrow Gain Margin: %.2f dB\nat Wcg = %.2f rad/s', GM_dB, Wcg), ...
        'FontSize', 9, 'Color', 'r');
else
    fprintf('No valid gain crossover frequency (Wcg).\n');
end

% Annotate Phase Margin at Phase Crossover Frequency (Wcp)
if is_Wcp_valid
    y_phase = interp1(w, phase, Wcp);
    plot(Wcp, y_phase, 'bs', 'MarkerSize', 8, 'LineWidth', 2);
    text(Wcp, y_phase - 25, ...
        sprintf('\\leftarrow Phase Margin: %.2f°\nat Wcp = %.2f rad/s', PM, Wcp), ...
        'FontSize', 9, 'Color', 'b');
else
    fprintf('No valid phase crossover frequency (Wcp).\n');
end

hold off;



