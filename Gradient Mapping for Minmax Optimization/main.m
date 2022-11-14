A0 = [3., 2.; 4., 5.];
b0 = [2.; 4.];
c0 = 1.;

A1 = [5., 2.; 2., 3.];
b1 = [5.; 0.];
c1 = -46.;

A2 = [20., 0.; 0., 1.];
b2 = [4.; 0.];
c2 = -50.;

A3 = [10., 1.; -15., 20.];
b3 = [0.; -25.];
c3 = -101.;

lb = [-5., 1.5];
ub = [5., 6.5];

x0 = [-2.5; 1.5];
t0 = 4.5;
ka = 0.45;
mu = 0.5;
L = 30.0;
beta = (sqrt(L) - sqrt(mu))/(sqrt(L) + sqrt(mu));
epsilon = 1e-4;

tk = t0;
xk = x0;
k = 0;
get_optim = false;
while true
    % inner scheme
    xkk = xk;
    ykk = xkk;
    f_star_xkj_list = [];
    keep_L_list = [];
    while true
        term_func_kmu = @(x)[linearization_quad(xkk, x, A0, b0, c0, mu)-tk, 
                             linearization_quad(xkk, x, A1, b1, c1, mu),
                             linearization_quad(xkk, x, A2, b2, c2, mu),
                             linearization_quad(xkk, x, A3, b3, c3, mu)];
        term_func_kL = @(x)[linearization_quad(xkk, x, A0, b0, c0, L)-tk, 
                            linearization_quad(xkk, x, A1, b1, c1, L),
                            linearization_quad(xkk, x, A2, b2, c2, L),
                            linearization_quad(xkk, x, A3, b3, c3, L)];
        [no_keep_mu, f_star_kmu] = fminimax(term_func_kmu, xkk, [], [], [], [], lb, ub);
        [keep_L, f_star_kL] = fminimax(term_func_kL, xkk, [], [], [], [], lb, ub);
        f_star_kmu = max(f_star_kmu);
        f_star_kL = max(f_star_kL);
        
        if f_star_kL <= epsilon % I use the global stop mentioned in the course slides
            x_optim = xkk
            t_optim = quadfunc(x_optim, A0, b0, c0)
            get_optim = true;
            break
        end

        keep_L_list = [keep_L_list, keep_L];
        f_star_xkj_list = [f_star_xkj_list, f_star_kL];
        x_k_j_k = xkk;
        if f_star_kmu >= (1-ka) * f_star_kL
            break
        end

        func_kL = @(x)[linearization_quad(ykk, x, A0, b0, c0, L)-tk, 
                       linearization_quad(ykk, x, A1, b1, c1, L),
                       linearization_quad(ykk, x, A2, b2, c2, L),
                       linearization_quad(ykk, x, A3, b3, c3, L)];
        [xkk1, f_star_kk1] = fminimax(func_kL, xkk, [], [], [], [], lb, ub); % use xkk as the initial point
        ykk1 = xkk1 + beta * (xkk1 - xkk);
        xkk = xkk1;
        ykk = ykk1;
    end

    if get_optim
        break
    end

    [no_keep_min, j_star_k] = min(f_star_xkj_list);
    xk1 = keep_L_list(:, j_star_k); % I use the pseudo code provided in the course slides
    %xk1 = x_k_j_k;
    xk = xk1;
    % find the root through bisection method
    LE = -100.;
    RE = 100.;
    tk1 = (LE + RE) / 2;
    while true
        root_func_mu = @(x)[linearization_quad(x_k_j_k, x, A0, b0, c0, mu)-tk1, 
                            linearization_quad(x_k_j_k, x, A1, b1, c1, mu),
                            linearization_quad(x_k_j_k, x, A2, b2, c2, mu),
                            linearization_quad(x_k_j_k, x, A3, b3, c3, mu)];
        [no_keep_root, f_star_root] = fminimax(root_func_mu, x_k_j_k, [], [], [], [], lb, ub);
        f_star_root = max(f_star_root);
        if f_star_root < -1e-6
            RE = tk1;
            tk1 = (LE + RE) / 2;
        elseif f_star_root > 1e-6
            LE = tk1;
            tk1 = (LE + RE) / 2;
        else
            break
        end
    end
    tk = tk1;
    k = k+1;
end


