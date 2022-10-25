syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) = (tan(x1.^2 + 2*x2.^2 + 3*x3.^2 ...
    + 4*x4.^2 + 5*x5.^2 + 6*x6.^2 + 7*x7.^2 + 8*x8.^2 + 9*x9.^2 + 10*x10.^2) ...
    - 10).^2;

x0 = [1.3, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0];

e_list = [1e-10, 1e-15, 1e-20];

sr1_m_ls = []; sr1_t_ls = []; sr1_iter_ls = [];
sr1_bts_m_ls = []; sr1_bts_t_ls = []; sr1_bts_iter_ls = [];
bfgs_m_ls = []; bfgs_t_ls = []; bfgs_iter_ls = [];
bfgs_bts_m_ls = []; bfgs_bts_t_ls = []; bfgs_bts_iter_ls = [];
gs_m_ls = []; gs_t_ls = []; gs_iter_ls = [];
cgs_m_ls = []; cgs_t_ls = []; cgs_iter_ls = [];

for e = e_list

    disp('For BFGS')
    [minimum, duration, iters] = BFGS(f,x0,e,0);
    bfgs_m_ls = [bfgs_m_ls, minimum];
    bfgs_t_ls = [bfgs_t_ls, duration];
    bfgs_iter_ls = [bfgs_iter_ls, iters];

    disp('For BFGS with BTS')
    [minimum, duration, iters] = BFGS(f,x0,e,1);
    bfgs_bts_m_ls = [bfgs_bts_m_ls, minimum];
    bfgs_bts_t_ls = [bfgs_bts_t_ls, duration];
    bfgs_bts_iter_ls = [bfgs_bts_iter_ls, iters];

    disp('For SR1')
    [minimum, duration, iters] = SR1(f,x0,e,0);
    sr1_m_ls = [sr1_m_ls, minimum];
    sr1_t_ls = [sr1_t_ls, duration];
    sr1_iter_ls = [sr1_iter_ls, iters];

    disp('For SR1 with BTS')
    [minimum, duration, iters] = SR1(f,x0,e,1);
    sr1_bts_m_ls = [sr1_bts_m_ls, minimum];
    sr1_bts_t_ls = [sr1_bts_t_ls, duration];
    sr1_bts_iter_ls = [sr1_bts_iter_ls, iters];

    disp('For Gradient Search')
    [minimum, duration, iters] = GradientSearch(f,x0,e);
    gs_m_ls = [gs_m_ls, minimum];
    gs_t_ls = [gs_t_ls, duration];
    gs_iter_ls = [gs_iter_ls, iters];

    disp('For Coordinate Gradient Search')
    [minimum, duration, iters] = CoordinateGradientSearch(f,x0,e);
    cgs_m_ls = [cgs_m_ls, minimum];
    cgs_t_ls = [cgs_t_ls, duration];
    cgs_iter_ls = [cgs_iter_ls, iters];

end

figure(1)
plot(e_list, sr1_m_ls, e_list, bfgs_m_ls, e_list, sr1_bts_m_ls, e_list, bfgs_bts_m_ls, e_list, gs_m_ls, e_list, cgs_m_ls)
title('N=10')
xlabel('tolerance')
ylabel('minimum achieved')
legend('SR1', 'BFGS', 'SR1 with BTS', 'BFGS with BTS', 'Gradient Search', 'Coordinate GS')

figure(2)
plot(e_list, sr1_t_ls, e_list, bfgs_t_ls, e_list, sr1_bts_t_ls, e_list, bfgs_bts_t_ls, e_list, gs_t_ls, e_list, cgs_t_ls)
title('N=10')
xlabel('tolerance')
ylabel('cpu time')
legend('SR1', 'BFGS', 'SR1 with BTS', 'BFGS with BTS', 'Gradient Search', 'Coordinate GS')

figure(3)
plot(e_list, sr1_iter_ls, e_list, bfgs_iter_ls, e_list, sr1_bts_iter_ls, e_list, bfgs_bts_iter_ls, e_list, gs_iter_ls, e_list, cgs_iter_ls)
title('N=10')
xlabel('tolerance')
ylabel('training iterations')
legend('SR1', 'BFGS', 'SR1 with BTS', 'BFGS with BTS', 'Gradient Search', 'Coordinate GS')





