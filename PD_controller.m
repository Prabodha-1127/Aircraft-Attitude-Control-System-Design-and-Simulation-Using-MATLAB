%step responses for varies z values
%2022e116
clc;
clear;
close all;

% System parameters (example: s(s + 0.7224) in denominator)
a = 1;           % Kd
b = 0.7224;      % plant parameter
z_values = [0.5, 1, 2, 3, 5];
colors = 'rbgck';  % color code for plotting
labels = {};

% Plot step responses
figure;
for i = 1:length(z_values)
    z = z_values(i);
    
    % Define controller: C(s) = Kd*s + Kp = a*s + a*z
    num_ol = a * [1 z];                  % numerator of open-loop C(s)*G(s)
    den_ol = conv([1 0], [1 b]);         % plant: s(s + b)

    % Match polynomial lengths (manual addition of num + den)
    len_diff = length(den_ol) - length(num_ol);
    if len_diff > 0
        num_ol = [zeros(1, len_diff), num_ol];
    elseif len_diff < 0
        den_ol = [zeros(1, -len_diff), den_ol];
    end

    % Closed-loop TF: T(s) = C(s)G(s) / (1 + C(s)G(s)) => num / (num + den)
    den_cl = den_ol + num_ol;
    sys_cl = tf(num_ol, den_cl);

    % Step response
    [y, t] = step(sys_cl, 0:0.1:20);
    plot(t, y, colors(i), 'LineWidth', 1.5); hold on;
    
    % Label for legend
    labels{end+1} = sprintf('z = %.1f', z);
end

grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Step Response for Various z = Kp/Kd');
legend(labels, 'Location', 'southeast');
