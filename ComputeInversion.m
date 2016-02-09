function [D_eff, A, c, C] = ComputeInversion(phi, ...
                                             phi_max, ...
                                             D1, ...
                                             C1, ...
                                             D2, ...
                                             C2, ...
                                             max_l, ...
                                             fComputeLatticeSum)
% Computes effective diffusion coefficient as a fucntion of lattice density for
% face centered cubic or simple cubic lattices using direct inversion method described
% in the paper: "The effective translational self-diffusion coefficient of small
% molecules in colloidal crystals of spherical particles", Blees and Leyte,
% Journal of Colloid and Interface Science 166, 118-127, 1994, doi:
% 10.1006/jcis.1994.1278
% The names of the variables correspond to the ones found in the paper.

a_by_d = 0.5 * nthroot(phi/phi_max, 3);

% TODO probably remove d if everything works, although maybe it is needed,
% when phi ~= phi_max, maybe also the lattice nearest neighbor distance is
% different?
d = 1;

b = (1 - D1*C1/(D2*C2) ) ./ (1 + ([1:max_l] ./([1:max_l]+1)) * (D1*C1/(D2*C2)) );

total_equations = max_l*(max_l+2);
A = zeros(total_equations);
% C = cell(total_equations, total_equations);

% lp and mp stand for l prime and m prime
equation_num = 1;
for l = 1:2:max_l
    max_m = 4 * floor(l / 4);
    for m = -max_m : 4 : max_m
        variable_num = 1;
        for lp = 1:2:max_l
            max_mp = 4 * floor(lp / 4);
            for mp = -max_mp : 4 : max_mp
                 A(equation_num, variable_num) = ...
                     ComputeCoefficients(l, m, lp, mp, b(l), a_by_d, d, fComputeLatticeSum);
                C{equation_num, variable_num} = sprintf('%i %i, %i %i', l, m, lp, mp);
                 variable_num = 1 + variable_num;
            end
        end
        equation_num = 1 + equation_num;
    end
end

total_equations = equation_num - 1;
A = A(1:total_equations, 1:total_equations);

c = zeros(total_equations, 1);
c(1) = 0.5 * sqrt(4/3*pi) * b(1);

p = A \ c;

moment = sqrt(3/(4*pi)).*p(1);
D_eff = 1 ./ (1 - phi*(1 - C1/C2) ) .* (1 - 2*phi.* moment) ./ ...
    (1 + phi.* moment);
end

function a = ComputeCoefficients(l, m, lp, mp, b_l, a_by_d, d, fComputeLatticeSum)
a = 0;
if l == lp && m == mp
    a = 1;
end

a = a - l/(l+1) * b_l * a_by_d^(l + lp + 1) * H(l, m, lp, mp) * ...
    U(l + lp, m - mp, d, fComputeLatticeSum);
assert(isfinite(a));
end

