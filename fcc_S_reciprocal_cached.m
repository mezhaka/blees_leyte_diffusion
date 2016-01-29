function s = fcc_S_reciprocal_cached(l, m)
global fcc_S_lm;
global fcc_S_lm_negative;

if m < 0
    m_as_index = abs(m) + 1;
    sz = size(fcc_S_lm_negative);
    if l > sz(1) || m_as_index > sz(2)
        tmp = nan(max(l, sz(1)), max(m_as_index, sz(2)) );
        tmp(1:sz(1), 1:sz(2)) = fcc_S_lm_negative;
        fcc_S_lm_negative = tmp;
    end
    if isnan(fcc_S_lm_negative(l, m_as_index))
        fcc_S_lm_negative(l, m_as_index) = fcc_S_reciprocal(l, m);
    end
    s = fcc_S_lm_negative(l, m_as_index);
else
    m_as_index = m + 1;
    sz = size(fcc_S_lm);
    if l > sz(1) || m_as_index > sz(2)
        tmp = nan(max(l, sz(1)), max(m_as_index, sz(2)) );
        tmp(1:sz(1), 1:sz(2)) = fcc_S_lm;
        fcc_S_lm = tmp;
    end
    if isnan(fcc_S_lm(l, m_as_index))
        fcc_S_lm(l, m_as_index) = fcc_S_reciprocal(l, m);
    end
    s = fcc_S_lm(l, m_as_index);
end
end