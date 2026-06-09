clc;
clear;

% Damping ratios
zeta_underdamped = 0.5;
zeta_critical = 1;
zeta_overdamped = 2;

% Natural frequency
wn = sqrt(1/36);  % ω_n = 1/6

% Define Laplace variable
s = tf('s');

% Transfer functions with unity DC gain (wn^2 numerator)
G_underdamped = wn^2 / (s^2 + 2*zeta_underdamped*wn*s + wn^2);
G_critical = wn^2 / (s^2 + 2*zeta_critical*wn*s + wn^2);
G_overdamped = wn^2 / (s^2 + 2*zeta_overdamped*wn*s + wn^2);

% Time vector for step response
t = linspace(0, 50, 1000);

%% Step Response Plot
figure;
hold on;
[y1, t1] = step(G_underdamped, t);
[y2, t2] = step(G_critical, t);
[y3, t3] = step(G_overdamped, t);

plot(t1, y1, 'r', 'LineWidth', 2);
plot(t2, y2, 'b--', 'LineWidth', 2);
plot(t3, y3, 'g-.', 'LineWidth', 2);

title('Step Response Comparison for Different Damping Conditions');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Underdamped (\zeta = 0.5)', 'Critically Damped (\zeta = 1)', 'Overdamped (\zeta = 2)', 'Location', 'Southeast');
ylim([0 1.2]);
grid on;

%% Phase vs Frequency Plot
w = logspace(-1, 2, 1000);  % Frequency range: 0.1 to 100 rad/s

[~, phase_u] = bode(G_underdamped, w); phase_u = squeeze(phase_u);
[~, phase_c] = bode(G_critical, w); phase_c = squeeze(phase_c);
[~, phase_o] = bode(G_overdamped, w); phase_o = squeeze(phase_o);

figure;
semilogx(w, phase_u, 'r', 'LineWidth', 2); hold on;
semilogx(w, phase_c, 'b--', 'LineWidth', 2);
semilogx(w, phase_o, 'g-.', 'LineWidth', 2);

xlabel('Frequency (rad/s)');
ylabel('Phase (degrees)');
title('Phase Gain vs Frequency');
legend('Underdamped (\zeta = 0.5)', 'Critically Damped (\zeta = 1)', 'Overdamped (\zeta = 2)', 'Location', 'SouthWest');
grid on;
