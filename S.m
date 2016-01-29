function s = S(l, m)
assert(~isequal(l, 0));
s = 0;
layers = 15;

%SC
% r1 = [1 0 0];
% r2 = [0 1 0];
% r3 = [0 0 1];

%FCC
r1 = (1/sqrt(2)) * [1 1 0];
r2 = (1/sqrt(2)) * [0 1 1];
r3 = (1/sqrt(2)) * [1 0 1];

for i = -layers:layers
    for j = -layers:layers
        for k = -layers:layers
            if i == 0 && j == 0 && k == 0
                continue;
            end
            R_lambda = i*r1 + j*r2 + k*r3;
            [theta, phi] = cart2sph(R_lambda(1), R_lambda(2), R_lambda(3));
            theta_lambda = pi/2 - phi;
            phi_lambda = theta;
            s = s + compute_Ylm(l, m, theta_lambda, phi_lambda) / norm(R_lambda)^(l+1);
        end
    end
end
end