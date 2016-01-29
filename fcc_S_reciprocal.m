function s = fcc_S_reciprocal(l, m)
% FCC
r1 = (1/sqrt(2)) * [1 1 0];
r2 = (1/sqrt(2)) * [0 1 1];
r3 = (1/sqrt(2)) * [1 0 1];
h1 = (1/sqrt(2)) * [1 1 -1];
h2 = (1/sqrt(2)) * [-1 1 1];
h3 = (1/sqrt(2)) * [1 -1 1];

s = S_reciprocal(l, m, r1, r2, r3, h1, h2, h3);
end