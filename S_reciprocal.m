function s = S_reciprocal(l, m, r1, r2, r3, h1, h2, h3)
assert(~isequal(l, 0));
assert(abs(m) <= l);

s = 0;
layers = 5;

% nu_r = dot(r1, cross(r2, r3));
nu_r = dot(r1, cross(r2, r3));

Gamma_bl = @(n, x) gammainc(x, n, 'upper') * gamma(n);
gamma_coeff = Gamma_bl(l + 0.5, 0);
range = [-layers:layers];
for i = range
    for j = range
        for k = range
            if i == 0 && j == 0 && k == 0
                continue;
            end
            R_lambda = i*r1 + j*r2 + k*r3;
            [theta, phi] = cart2sph(R_lambda(1), R_lambda(2), R_lambda(3));
            theta_lambda = pi/2 - phi;
            phi_lambda = theta;
            
            sum_term = Gamma_bl(l + 0.5, pi*dot(R_lambda, R_lambda)) ...
                / norm(R_lambda)^(l+1) ...
                * (compute_Ylm(l, m, theta_lambda, phi_lambda) / gamma_coeff);
            s = s + sum_term;
            
            if ~isfinite(s)
                assert(0);
            end
            
            H_lambda = i*h1 + j*h2 + k*h3;
            [theta, phi] = cart2sph(H_lambda(1), H_lambda(2), H_lambda(3));
            theta_lambda = pi/2 - phi;
            phi_lambda = theta;
            
            sum_term = (1i)^l * pi^(l - 0.5) / nu_r * norm(H_lambda)^(l-2) ...
                * exp(-pi*dot(H_lambda, H_lambda)) ...
                * (compute_Ylm(l, m, theta_lambda, phi_lambda) / gamma_coeff);
            s = s + sum_term;

            if ~isfinite(s)
                assert(0);
            end
        end
    end
end

% s = s/Gamma_bl(l + 0.5, 0);
end