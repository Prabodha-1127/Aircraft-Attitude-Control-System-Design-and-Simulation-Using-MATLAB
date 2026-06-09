%2022e116
% Closed-Loop System Step and Frequency Response for Given ζ

clc; clear;

a = 9;
b = 0.7224;

% K values for different damping ratios
K_over = 0.0036;   % Overdamped (ζ = 2)
K_crit = 0.0145;   % Critically damped (ζ = 1)
K_under = 0.058;   % Underdamped (ζ = 0.5)

K_values = [K_over, K_crit, K_under];
damping_labels = {'Overdamped (ζ = 2)', 'Critically Damped (ζ = 1)', 'Underdamped (ζ = 0.5)'};

% Preallocate for result table
results = [];

for i = 1:length(K_values)
    K = K_values(i);
    label = damping_labels{i};
    
    num = a * K;
    den = [1, b, a*K];
    sys_cl = tf(num, den);

    % Step response plot
    figure;
    step(sys_cl);
    title(['Step Response - ', label, ' (K = ', num2str(K), ')']);
    grid on;

    % Bode plot
    figure;
    bode(sys_cl);
    title(['Bode Plot - ', label, ' (K = ', num2str(K), ')']);
    grid on;

    % Get response metrics
    S = stepinfo(sys_cl);
    steady_state_val = dcgain(sys_cl);  % For offset calculation (1 - steady-state gain)

    % Display and store metrics
    fprintf('%s\n', label);
    fprintf('K = %.4f\n', K);
    fprintf('Rise Time = %.4f s\n', S.RiseTime);
    fprintf('Overshoot = %.2f %%\n', S.Overshoot);
    fprintf('Settling Time = %.4f s\n', S.SettlingTime);
    fprintf('Steady-State Error = %.4f\n\n', abs(1 - steady_state_val));

    results = [results; K, S.RiseTime, S.Overshoot, S.SettlingTime, abs(1 - steady_state_val)];
end

% Display results in table form
T = array2table(results, ...
    'VariableNames', {'K', 'RiseTime', 'Overshoot_pct', 'SettlingTime', 'Offset'});
disp('Step Response Characteristics Summary:');
disp(T);
