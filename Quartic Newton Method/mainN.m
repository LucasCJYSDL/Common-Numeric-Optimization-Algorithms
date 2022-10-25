for v = [1.30 1.32 1.34 1.36 1.38]
    m = v;
    i = 1;
    tic
    while i
        m_prime = m - f(m)/fp(m);
        if abs(f(m_prime)) >= 1e-20 | i > 1e6
            m = m_prime;
        else 
            break
        end
        i = i+1;
    end
    fprintf('%s%.22f\n', "X0 = ", v)
    fprintf('%s%.22f\t%s%d\n', 'X=', m_prime, 'i=', i)
    if not(isinf(m))
        fprintf('%s', "Convergent!") 
    else
        fprintf('%s', "Divergent!") 
    end
    toc
end