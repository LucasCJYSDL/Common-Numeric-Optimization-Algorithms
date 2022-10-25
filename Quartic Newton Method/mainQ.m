for v = [1.30 1.32 1.34 1.36 1.38]
    m = v;
    i = 1;
    tic
    while i
        fpppv = fppp(m);
        fppv = fpp(m);
        fpv = fp(m);
        fv = f(m);
        a = fpppv / 6;
        b = fpppv / 6 * (-3*m) + fppv  / 2;
        c = fpppv / 6 * (3*m*m) + fppv  / 2 * (-2 * m) + fpv;
        d = fpppv / 6 * (-m*m*m) + fppv  / 2 * (m * m) + fpv * (-m) + fv;
        m_prime_list = cubic(a, b, c, d);
        m_prime = pick_one_real_root(m_prime_list);
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

function real_root = pick_one_real_root(root_list)
real_root = 0;
for i=1:length(root_list)
    r = root_list(i);
    if abs(imag(r)) < 1e-14
        real_root = real(r);
        break
    end
end
for i=1:length(root_list)
    r = root_list(i);
    if (abs(imag(r)) < 1e-14) & (abs(f(r)) < abs(f(real_root)))
        real_root = real(r);
    end
end
end
