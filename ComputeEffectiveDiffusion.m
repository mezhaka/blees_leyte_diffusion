function [D_eff] = ComputeEffectiveDiffusion(phi_range, ...
                                             lattice_info, ... 
                                             particle_info,  ... 
                                             continuous_phase_info)
% Computes effective diffusion coefficient as a fucntion of lattice density for
% face centered cubic or simple cubic lattices using inversion method described
% in the paper: "The effective translational self-diffusion coefficient of small
% molecules in colloidal crystals of spherical particles", Blees and Leyte,
% Journal of Colloid and Interface Science 166, 118-127, 1994, doi:
% 10.1006/jcis.1994.1278

% I experimented a bit with the precision and found that this number of
% equations was enough for me. You could get more precise results if you
% increase max_l.
max_l = 21;

D_eff = zeros(size(phi_range));
i = 1;
for phi = phi_range 
    phi
    [D_eff] = ComputeInversion(phi, ...
                               lattice_info.phi_max, ...
                               particle_info.diffusion_coefficient, 
                               particle_info.concentration, 
                               continuous_phase_info.diffusion_coefficient,
                               continuous_phase_info.concentration, ...
                               max_l, ...
                               lattice_info.compute_lattice_sum_function);
    D_eff(i) = D_eff;
    i = i + 1;
end
