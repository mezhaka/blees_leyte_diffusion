function [density_longitudinal_transverse,  f] = ...
    ExtractAssymptoticDiffusionFromTransient(porosity_folders, ...
                                             crystal_type, ...
                                             base_dir)
base_dir = fullfile(base_dir, crystal_type);
density_longitudinal_transverse = zeros(numel(porosity_folders), 3);
for i=1:numel(porosity_folders)
    dispersion_filepath = fullfile(base_dir, porosity_folders{i}, ...
        'tracers_0_000');
[l, t, f] = DispersionPlot(dispersion_filepath, 0.0281, 0.5);
close(f);
density = 1 - str2num(porosity_folders{i});
averaging_start = ceil(numel(l) * 0.66);
l_mean = mean(l(averaging_start:end));
t_mean = mean(t(averaging_start:end));

density_longitudinal_transverse(i,:) = [density, l_mean, t_mean];
end

f = figure; 
plot(density_longitudinal_transverse(:,1), density_longitudinal_transverse(:,2), 'o', 'DisplayName', 'Simulation, longitudinal direction');
hold on;
plot(density_longitudinal_transverse(:,1), density_longitudinal_transverse(:,3), 'x', 'DisplayName', 'Simulation, transverse direction');
% e = linspace(.28, .74); 
% plot(e, ComputeTheoreticalEffectiveDiffusion(e, crystal_type), 'r', 'DisplayName', 'Blees and Leyte, first 8 nonzero terms of the series');

xlabel('Density');
ylabel('Effective diffusion coefficient');
legend('show');
title(crystal_type);
end
%
%e = linspace(.3, .74); plot(e, ComputeTheoreticalEffectiveDiffusion(e), 'r');
%ImportColumnwiseData(
