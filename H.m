function h = H(l, m, lp, mp)
h = (-1)^(lp + m) * sqrt((2*lp + 1)/(2*l + 1)) * ...
    sqrt((partial_factorial(l  -  m + 1, l  -  m + lp + mp) / factorial( l +  m)) * ...
         (partial_factorial(lp - mp + 1, lp - mp +  l +  m) / factorial(lp + mp)) );
end


function f = partial_factorial(first, last)
if first == 1 && last == 0
    f = 1;
    return;
end

assert(first <= last);
assert(first >= 0);

f = prod(first:last);

end