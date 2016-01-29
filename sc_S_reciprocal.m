function s = sc_S_reciprocal(l, m)
% SC
r1 = [1 0 0];
r2 = [0 1 0];
r3 = [0 0 1];
h1 = [1 0 0];
h2 = [0 1 0];
h3 = [0 0 1];

s = S_reciprocal(l, m, r1, r2, r3, h1, h2, h3);
end