%2022e116
% Step + Frequency Response + Resonant Peak + Bandwidth

clc; clear;

a = 9;
b = 0.7224;

% K values for damping cases
K_values = [0.0036, 0.0145, 0.058];
labels = {'Overdamped (ζ=2)', 'Critically Damped (ζ=1)', 'Underdamped (ζ=0.5)'};

results = [];

for i = 1:length(K_values)
    K = K_values(i);
    label = labels{i};

    % Closed-loop transfer function
    num = a * K;
    den = [1, b, a*K];
    sys_cl = tf(num, den);

    % Step response
    figure;
    step(sys_cl);
    title(['Step Response - ', label, ' (K = ', num2str(K), ')']);
    grid on;

    % Bode plot
    figure;
    [mag, phase, wout] = bode(sys_cl);
    bode(sys_cl);
    title(['Bode Plot - ', label, ' (K = ', num2str(K), ')']);
    grid on;

    % Step metrics
    S = stepinfo(sys_cl);
    steady_state_error = abs(1 - dcgain(sys_cl));

    % Resonant peak (max magnitude in dB)
    mag_db = 20*log10(squeeze(mag));
    [Mr_dB, idx_Mr] = max(mag_db);

    % Bandwidth = frequency where magnitude drops to -3 dB
    idx_bw = find(mag_db <= (mag_db(1) - 3), 1);
    if ~isempty(idx_bw)
        w_bw = wout(idx_bw);
    else
        w_bw = NaN;  % if no -3 dB point
    end

    % Print metrics
    fprintf('%s\n', label);
    fprintf('K = %.4f\n', K);
    fprintf('Rise Time = %.3f s, Overshoot = %.2f%%, Settling Time = %.3f s, Offset = %.4f\n', ...
        S.RiseTime, S.Overshoot, S.SettlingTime, steady_state_error);
    fprintf('Resonant Peak (dB) = %.2f, Bandwidth = %.2f rad/s\n\n', Mr_dB, w_bw);

    % Append results
    results = [results; K, S.RiseTime, S.Overshoot, S.SettlingTime, ...
               steady_state_error, Mr_dB, w_bw];
end

% Create and display extended table
T = array2table(results, ...
    'VariableNames', {'K', 'RiseTime', 'Overshoot_pct', 'SettlingTime', ...
                      'Offset', 'ResonantPeak_dB', 'Bandwidth_rad_per_s'});
disp('Extended Step + Frequency Domain Characteristics:');
disp(T);
