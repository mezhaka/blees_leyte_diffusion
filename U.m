function u = U(l, m, d, fComputeLatticeSum)
if mod(l,2) == 1 || mod(m, 4) ~= 0
    error('should not get here');
%     u = 0;
%     return;
end

%u = sqrt(4*pi/(2*l + 1)) * d^(l+1) * S_reciprocal(l, m);
u = sqrt(4*pi/(2*l + 1)) * d^(l+1) * fComputeLatticeSum(l, m);
end



