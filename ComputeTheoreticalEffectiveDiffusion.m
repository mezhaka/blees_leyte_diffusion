function deff_theory = ComputeTheoreticalEffectiveDiffusion(phi, crystal_type, D1, C1, D2, C2)
if isequal(crystal_type, 'fcc')
    phi_max = pi/6 * sqrt(2);
    u4_0 = -1.33036691;
    u6_0 = 0.57332929;
    u8_0 = 3.25929310;
    u10_0 = -0.03368359;
elseif isequal(crystal_type, 'sc')
    phi_max = pi/6 * sqrt(2);
    u4_0 = 3.10822674;
    u6_0 = -2.35421422;
    u8_0 = 3.58796820;
    u10_0 = 1.00922399;
else
    error('unsupported crystal type');
end

j = 1:100;
b = (1 - D1*C1/(D2*C2) ) ./ (1 + (j./(j+1)) * (D1*C1/(D2*C2)) );

m = zeros(1, 25);

m(1) = 0.5*b(1);
m(11) = 3*2^-10 * u4_0^2 * b(1)^2 * b(3);
m(15) = (55/3)*2^-13 * u6_0^2 * b(1)^2 * b(5);
m(18) = -45*2^-17 * u4_0^2 * u6_0 * b(1)^2 * b(3)^2;
m(19) = (35/33)*2^-14 * u8_0^2 * b(1)^2 * b(7);
m(22) = -(35/3)*2^-17 * u4_0 * u6_0 * u8_0 * b(1)^2 * b(3) * b(5);
m(23) = (171/65)*2^-17 * u10_0^2 * b(1)^2 * b(9);
m(25) = (675)*2^-24 * u4_0^2 * u6_0^2 * b(1)^2 * b(3)^3;

nonzero_sum = 0;
for j = 1:25
    i = j - 1;
    m_ith = m(j);
    nonzero_sum = nonzero_sum + m_ith*(phi./phi_max).^(i/3);
end

deff_theory = 1 ./ (1 - phi*(1 - C1/C2) ) .* (1 - 2*phi.*nonzero_sum) ./ ...
    (1 + phi.*nonzero_sum);
end
