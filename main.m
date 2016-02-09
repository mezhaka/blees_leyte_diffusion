% This script consists of two parts: The first one is to help visualize how
% the error in the method of direct inversion converges with the increasing
% number of lattice sums. The second part plots the effective diffusion
% coefficients for FCC and SC crystals. One can adjust the diffusion
% coefficients (D1, D2), effective concentrations (C1, C2), and density
% (phi) to compute the effective diffusion in the desireable system.
%% Visualize the convergence of the D_eff for FCC lattice with maximum density.
%  Plot the dependecy of the D_eff on l -- the number that defines the amount of 
%  equations in the matrix to compute lattice sums S_{l,m}. 
phi = fcc_phi_max;
D = [];
l_range = 1:2:21;
for l = l_range;
    [D_eff, A, ~] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, l, @fcc_S_reciprocal_cached);
    D(end+1) = D_eff;
end

figure;

% The horizontal line computes the theoretically derived value with a
% limited number of terms. According to the paper this value poorly
% describes the behavior of the system with high density.
subplot(2, 1, 1);
title(sprintf('Convergence, \\phi = %f', phi));
plot(l_range, real(D), 'o');
hline(ComputeTheoreticalEffectiveDiffusion(phi, 'fcc', D1, C1, D2, C2));
ylabel('real(D_{eff})');

% Ensure that the imaginary part is negligible
subplot(2,1, 2);
plot(l_range, imag(D), 'o');
ylabel('imag(D_{eff})');
xlabel('l_max');

%% I played a bit with precision and this amount of terms was enough for me:
max_l = 21;

% Diffusion coefficient and concentration inside of the particle.
D1 = .1;
C1 = 1;

% Diffusion coefficient and concentration in the continuous phase.
D2 = 1;
C2 = 1;

% Let's compute effective diffusion for FCC lattice
% Maximum density of the FCC lattice
fcc_phi_max = pi/6 * sqrt(2);
fcc_phi_range = linspace(0.3, fcc_phi_max, 20);
fcc_D_eff = [];
for phi = fcc_phi_range 
    [D_eff, ~, ~] = ComputeInversion(phi, fcc_phi_max, D1, C1, D2, C2, ...
        max_l, @fcc_S_reciprocal_cached);
    fcc_D_eff(end+1) = D_eff;
end

% Let's compute effective diffusion for SC lattice
% Maximum density of the SC lattice
sc_phi_max = pi/6;
sc_phi_range = linspace(0.3, sc_phi_max, 20);
sc_D_eff = [];
for phi = sc_phi_range 
    [D_eff, A, c] = ComputeInversion(phi, sc_phi_max, D1, C1, D2, C2, ...
        max_l, @sc_S_reciprocal_cached);
    sc_D_eff(end+1) = D_eff;
end

figure;
plot(fcc_phi_range, real(fcc_D_eff), 'o', 'DisplayName', 'FCC');
hold on;
plot(sc_phi_range, real(sc_D_eff), 'o', 'DisplayName', 'SC');
xlabel('\phi');
ylabel('D_{eff}');
legend('show');