syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20) = ...
    (tan(x1.^2 + 2*x2.^2 + 3*x3.^2 + 4*x4.^2 + 5*x5.^2 + 6*x6.^2 + 7*x7.^2 ...
    + 8*x8.^2 + 9*x9.^2 + 10*x10.^2 + 11*x11.^2 + 12*x12.^2 + 13*x13.^2 ...
    + 14*x14.^2 + 15*x15.^2 + 16*x16.^2 + 17*x17.^2 + 18*x18.^2 ...
    + 19*x19.^2 + 20*x20.^2) - 10).^2;

x0 = [0, 0, 0.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

e_list = [1e-10, 1e-15, 1e-20];
sr1_bts_m_ls = []; sr1_bts_t_ls = []; sr1_bts_iter_ls = [];
bfgs_bts_m_ls = []; bfgs_bts_t_ls = []; bfgs_bts_iter_ls = [];
nt_m_ls = []; nt_t_ls = []; nt_iter_ls = [];
cgm_m_ls = []; cgm_t_ls = []; cgm_iter_ls = [];

for e = e_list
    disp('For BFGS with BTS')
    [minimum, duration, iters] = BFGS(f,x0,e,1);
    bfgs_bts_m_ls = [bfgs_bts_m_ls, minimum];
    bfgs_bts_t_ls = [bfgs_bts_t_ls, duration];
    bfgs_bts_iter_ls = [bfgs_bts_iter_ls, iters];

    disp('For SR1 with BTS')
    [minimum, duration, iters] = SR1(f,x0,e,1);
    sr1_bts_m_ls = [sr1_bts_m_ls, minimum];
    sr1_bts_t_ls = [sr1_bts_t_ls, duration];
    sr1_bts_iter_ls = [sr1_bts_iter_ls, iters];

    disp('For Newton Method')
    [minimum, duration, iters] = Newton(f,x0,e);
    nt_m_ls = [nt_m_ls, minimum];
    nt_t_ls = [nt_t_ls, duration];
    nt_iter_ls = [nt_iter_ls, iters];

    disp('For Conjugate Gradient Method with BTS')
    [minimum, duration, iters] = conjgrad(f,x0,e);
    cgm_m_ls = [cgm_m_ls, minimum];
    cgm_t_ls = [cgm_t_ls, duration];
    cgm_iter_ls = [cgm_iter_ls, iters];
end

figure(1)
plot(e_list, sr1_bts_m_ls, e_list, bfgs_bts_m_ls, e_list, nt_m_ls, e_list, cgm_m_ls)
title('N=20')
xlabel('tolerance')
ylabel('minimum achieved')
legend('SR1 with BTS', 'BFGS with BTS', 'Newton Method', 'Conjugate Gradient Method')

figure(2)
plot(e_list, sr1_bts_t_ls, e_list, bfgs_bts_t_ls, e_list, nt_t_ls, e_list, cgm_t_ls)
title('N=20')
xlabel('tolerance')
ylabel('cpu time')
legend('SR1 with BTS', 'BFGS with BTS', 'Newton Method', 'Conjugate Gradient Method')

figure(3)
plot(e_list, sr1_bts_iter_ls, e_list, bfgs_bts_iter_ls, e_list, nt_iter_ls, e_list, cgm_iter_ls)
title('N=20')
xlabel('tolerance')
ylabel('training iterations')
legend('SR1 with BTS', 'BFGS with BTS', 'Newton Method', 'Conjugate Gradient Method')