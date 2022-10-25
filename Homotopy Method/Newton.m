function [m] = Newton(x0, t, init_x)
    
    m = x0;
    i = 1;
  
    while i
        m_prime = m - (t * fn(m) + (1 - t) * (m - init_x))/(t * fp(m) + (1 - t));
        if abs((t * fn(m_prime) + (1 - t) * (m_prime - init_x))) >= 1e-20 | i > 1e6
            m = m_prime;
        else 
            break
        end
        i = i+1;
    end

    fprintf('%s%.22f\t%s%d\n', 'X=', m_prime, 'i=', i)
    if not(isinf(m))
        fprintf('%s', "Convergent!") 
    else
        fprintf('%s', "Divergent!") 
    end
    
end

