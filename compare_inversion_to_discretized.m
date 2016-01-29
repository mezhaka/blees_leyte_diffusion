project_dir = 'C:\work\repo\journal\porous particles';
size_for_marker = containers.Map({'o', 'x', 'd', 'p', '*', 'h', 's'}, ...
                                 [ 5    6    5    5    5    5    5]);
kLabelFontSize = 12;
kAxesFontSize = 9;
SetAxesFontSize = @(fig_handle) set(gca, 'FontSize', kAxesFontSize);
eps_export_dir = fullfile(project_dir, 'figures', 'eps');

[figs] = PlotBleeysLeyteValidation(project_dir, ...
    size_for_marker,...
    kLabelFontSize,...
    SetAxesFontSize,...
    strrep(fullfile(eps_export_dir, 'validation_for_%s.eps'), '\', '\\') );

close(figs(2));
fcc_porosity_folders = {'0.2595',  '0.3500',  '0.4500',  '0.5500',  '0.6500', ...
'0.3000',  '0.4000',  '0.5000',  '0.6000',  '0.7000'};
% density_longitudinal_transverse = ...
%     ExtractAssymptoticDiffusionFromTransient(fcc_porosity_folders, 'fcc', base_dir);


D1 = 1;
D2 = 1;
C1 = .1;
C2 = 1;

fcc_phi_max = pi/6 * sqrt(2);

% [D_eff4, Acache, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, 7, @fcc_S_reciprocal_cached);
% [D_eff,  A, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, 7, @fcc_S_reciprocal_cached);
% isequal(Acache, A)

D = [];
porosities_fcc = cell2num(Map(@str2num, fcc_porosity_folders));
densities_fcc = 1 - porosities_fcc;
max_l = 7;
for i = 1:numel(densities_fcc)
    phi = densities_fcc(i);
    [D_eff, A, c] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, max_l, @fcc_S_reciprocal_cached);
    D(i) = D_eff;
end
hold on; 
plot(densities_fcc, real(D), 's', ...
    'DisplayName', sprintf('Inversion method, l = %i', max_l));
legend('hide'); legend('show');
