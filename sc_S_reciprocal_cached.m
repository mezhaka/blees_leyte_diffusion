function s = sc_S_reciprocal_cached(l, m)
global sc_S_lm;
global sc_S_lm_negative;

if m < 0
    m_as_index = abs(m) + 1;
    sz = size(sc_S_lm_negative);
    if l > sz(1) || m_as_index > sz(2)
        tmp = nan(max(l, sz(1)), max(m_as_index, sz(2)) );
        tmp(1:sz(1), 1:sz(2)) = sc_S_lm_negative;
        sc_S_lm_negative = tmp;
    end
    if isnan(sc_S_lm_negative(l, m_as_index))
        sc_S_lm_negative(l, m_as_index) = sc_S_reciprocal(l, m);
    end
    s = sc_S_lm_negative(l, m_as_index);
else
    m_as_index = m + 1;
    sz = size(sc_S_lm);
    if l > sz(1) || m_as_index > sz(2)
        tmp = nan(max(l, sz(1)), max(m_as_index, sz(2)) );
        tmp(1:sz(1), 1:sz(2)) = sc_S_lm;
        sc_S_lm = tmp;
    end
    if isnan(sc_S_lm(l, m_as_index))
        sc_S_lm(l, m_as_index) = sc_S_reciprocal(l, m);
    end
    s = sc_S_lm(l, m_as_index);
end
end