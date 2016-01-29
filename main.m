%% Setup some constants
% 1) Change this to the location of the script
base_dir = ['/Users/mezhaka/science/marburg_repo/journal/' ...
    'porous particles/blees_leyte_validation'];
cd(base_dir);
simulations_dir = fullfile(base_dir, 'reviewer3_simulations');

fcc_porosity_folders = {'0.2595',  '0.3500',  '0.4500',  '0.5500',  '0.6500', ...
'0.3000',  '0.4000',  '0.5000',  '0.6000',  '0.7000'};

sc_porosity_folders = { '0.476', '0.500', '0.550', '0.600',  '0.650', ...
'0.700'};

%% Extract new simulation data and write it to text files
[density_longitudinal_transverse, f]= ...
    ExtractAssymptoticDiffusionFromTransient(fcc_porosity_folders, 'fcc', simulations_dir);
close(f);
WriteTableToFile(fullfile(base_dir, 'fcc_additional_porous_simulation.txt'), ...
	'density\teffective_diffusion\n', density_longitudinal_transverse(:,1:2));

[density_longitudinal_transverse, f]= ...
    ExtractAssymptoticDiffusionFromTransient(sc_porosity_folders, 'sc', simulations_dir);
close(f);
WriteTableToFile(fullfile(base_dir, 'sc_additional_porous_simulation.txt'), ...
	'density\teffective_diffusion\n', density_longitudinal_transverse(:,1:2));

%% Compute D_eff = D_eff(phi) and write it to text files
% based on the convergence data I decided to truncate the system:
max_l = 21;

D1 = .1;
D2 = 1;
C1 = 1;
C2 = 1;

fcc_phi_max = pi/6 * sqrt(2);
fcc_phi_range = linspace(0.3, fcc_phi_max, 50);
fcc_D_eff = [];
for phi = fcc_phi_range 
    phi
    [D_eff, A, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, ...
        max_l, @fcc_S_reciprocal_cached);
    fcc_D_eff(end+1) = D_eff;
end
WriteTableToFile(fullfile(base_dir, 'fcc_additional_porous_inversion_method.txt'), ...
	'density\teffective_diffusion\n', [fcc_phi_range' real(fcc_D_eff')]);

sc_phi_max = pi/6;
sc_phi_range = linspace(0.3, sc_phi_max, 50);
sc_D_eff = [];
for phi = sc_phi_range 
    phi
    [D_eff, A, c] = ComputeInversion(phi, sc_phi_max, D1, C1, D2, C2, ...
        max_l, @sc_S_reciprocal_cached);
    sc_D_eff(end+1) = D_eff;
end
WriteTableToFile(fullfile(base_dir, 'sc_additional_porous_inversion_method.txt'), ...
	'density\teffective_diffusion\n', [sc_phi_range' real(sc_D_eff')]);



% global fcc_S_lm;
% global fcc_S_lm_negative;
% global sc_S_lm;
% global sc_S_lm_negative;
% fcc_S_lm = nan(2);
% sc_S_lm = nan(2);
% fcc_S_lm_negative = nan(2);
% sc_S_lm_negative = nan(2);

%%
fcc_porosity_folders = {'0.2595',  '0.3500',  '0.4500',  '0.5500',  '0.6500', ...
'0.3000',  '0.4000',  '0.5000',  '0.6000',  '0.7000'};
density_longitudinal_transverse = ...
    ExtractAssymptoticDiffusionFromTransient(fcc_porosity_folders, 'fcc', base_dir);


D1 = .1;
D2 = 1;
C1 = 1;
C2 = 1;

fcc_phi_max = pi/6 * sqrt(2);

% [D_eff4, Acache, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, 7, @fcc_S_reciprocal_cached);
% [D_eff,  A, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, 7, @fcc_S_reciprocal_cached);
% isequal(Acache, A)

D = [];
porosities_fcc = cell2num(Map(@str2num, fcc_porosity_folders));
densities_fcc = 1 - porosities_fcc;
max_l = 40;
for i = 1:numel(densities_fcc)
    phi = densities_fcc(i);
    [D_eff, A, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, max_l, @fcc_S_reciprocal_cached);
    D(i) = D_eff;
end
hold on; 
plot(densities_fcc, real(D), 's', ...
    'DisplayName', sprintf('Inversion method, l = %i', max_l));
legend('hide'); legend('show');

%%
% global fcc_S_lm;
% global fcc_S_lm_negative;
% global sc_S_lm;
% global sc_S_lm_negative;
% fcc_S_lm = nan(2);
% sc_S_lm = nan(2);
% fcc_S_lm_negative = nan(2);
% sc_S_lm_negative = nan(2);

%phi = .65;
phi = fcc_phi_max;
D = [];
l_range = 1:2:41;
for l = l_range;
    l
    [D_eff, A, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, l, @fcc_S_reciprocal_cached);
    D(end+1) = D_eff;
end
figure;
subplot(2, 1, 1);
title(sprintf('Convergence, \\phi = %f', phi));
plot(l_range, real(D), 'o');
hline(ComputeTheoreticalEffectiveDiffusion(phi, 'fcc', D1, C1, D2, C2));
ylabel('real(D_{eff})');
subplot(2,1, 2);
plot(l_range, imag(D), 'o');
ylabel('imag(D_{eff})');
xlabel('l_max');




%%
fcc_phi_max = pi/6 * sqrt(2);
phi = fcc_phi_max;
% phi = 0.524;

D1 = 1;
D2 = 1;
C1 = .1;
C2 = 1;
max_l = 7;
[D_eff,  Acache, c, C] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, max_l, @fcc_S_reciprocal_cached);
% [D_eff,  A, c, C] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, max_l, @fcc_S_reciprocal);

%SC
r1 = [1 0 0];
r2 = [0 1 0];
r3 = [0 0 1];
h1 = [1 0 0];
h2 = [0 1 0];
h3 = [0 0 1];

sc_r_basis = [r1; r2; r3];
sc_h_basis = [h1; h2; h3];

