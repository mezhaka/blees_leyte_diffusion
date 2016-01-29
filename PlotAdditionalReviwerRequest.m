porosity_folders = {'0.2595',  '0.3500',  '0.4500',  '0.5500',  '0.6500', ...
'0.3000',  '0.4000',  '0.5000',  '0.6000',  '0.7000'};

base_dir = ['C:\Users\self_000\repo\journal\porous particles\', ...
    'blees_leyte_validation\reviewer3_simulations'];
density_l_t = zeros(numel(porosity_folders), 3);
for i=1:numel(porosity_folders)
    dispersion_filepath = fullfile(base_dir, porosity_folders{i}, ...
        'tracers_0_000');
[l, t, f] = DispersionPlot(dispersion_filepath, 0.0281, 0.5);
close(f);
density = 1 - str2num(porosity_folders{i});
averaging_start = ceil(numel(l) * 0.66);
l_mean = mean(l(averaging_start:end));
t_mean = mean(t(averaging_start:end));

density_l_t(i,:) = [density, l_mean, t_mean];
end

figure; 
plot(density_l_t(:,1), density_l_t(:,2), 'o', 'DisplayName', 'Simulation, longitudinal direction');
hold on;
plot(density_l_t(:,1), density_l_t(:,3), 'x', 'DisplayName', 'Simulation, transverse direction');
e = linspace(.28, .74); 
plot(e, ComputeTheoreticalEffectiveDiffusion(e), 'r', 'DisplayName', 'Blees and Leyte, first 8 nonzero terms of the series');

xlabel('Density');
ylabel('Effective diffusion coefficient');
legend('show');

%
%e = linspace(.3, .74); plot(e, ComputeTheoreticalEffectiveDiffusion(e), 'r');
%ImportColumnwiseData(
