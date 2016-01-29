function [ longitudinal_dispersion_data, transverse_dispersion_data, ...
    figures, timesteps, vertical_dispersion_std, ...
    vertical_dispersion_mean, vertical_dispersion_data, ...
    average_ensemble_velocity] = DispersionPlot(path_to_data, ...
                                                diffusion_coeff, ...
                                                dispersion_time_step)
%DispersionPlot Plots longitudinal and transverse dispersion
%   [ longitudinal_dispersion_data, transverse_dispersion_data, figures, 
%     vertical_dispersion_std, vertical_dispersion_mean] = DispersionPlot( 
%           path_to_data, diffusion_coeff, dispersion_time_step )


%this is how the data is layed out in dispresion output:
longitudinal_dispersion = struct('column_number', 5, 'plot_name', ' longitudinal');
transverse_dispersion = struct('column_number', 6, 'plot_name', ' transverse');
vertical_dispersion = struct('column_number', 7, 'plot_name', ' vertical');
time_iterations = struct('column_number', 1, 'plot_name', 'none');

temp = load(path_to_data);
timesteps = temp(2:end, time_iterations.column_number);

stats_interval = temp(1,1); % The first time step is the the writing interval, because the write period is fixed.
MAGIC_NUMBA = 2;
derivative_scale = MAGIC_NUMBA*stats_interval*dispersion_time_step;

longitudinal_dispersion_data = diff( temp(:,longitudinal_dispersion.column_number) ) ...
    /diffusion_coeff/derivative_scale;

figures = figure('Name', path_to_data);
subplot(2,1,1);
plot(longitudinal_dispersion_data);
title('longitudinal');
grid on;
hold on;

transverse_dispersion_data = diff( temp(:, transverse_dispersion.column_number) )/diffusion_coeff/derivative_scale;
subplot(2,1,2);
plot(transverse_dispersion_data);
title('transverse');
grid on;
hold on;

vertical_dispersion_data = diff( temp(:, vertical_dispersion.column_number) )/diffusion_coeff/derivative_scale;
vertical_dispersion_mean = mean(vertical_dispersion_data);
vertical_dispersion_std = std(vertical_dispersion_data);

total_time = timesteps(end)*dispersion_time_step;
total_longitudinal_displacement = temp(end, 2);
average_ensemble_velocity = total_longitudinal_displacement / total_time;
end

