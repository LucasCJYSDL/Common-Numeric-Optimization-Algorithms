syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15
f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15) = ...
    (tan(x1.^2 + 2*x2.^2 + 3*x3.^2 + 4*x4.^2 + 5*x5.^2 + 6*x6.^2 + 7*x7.^2 ...
    + 8*x8.^2 + 9*x9.^2 + 10*x10.^2 + 11*x11.^2 + 12*x12.^2 + 13*x13.^2 ...
    + 14*x14.^2 + 15*x15.^2) - 10).^2;

x0 = [0.0, 0.0, 0.70, 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

e_list = [1e-10, 1e-15, 1e-20];

newton_m_ls = []; newton_t_ls = []; newton_iter_ls = [];
sr1_m_ls = []; sr1_t_ls = []; sr1_iter_ls = [];
bfgs_m_ls = []; bfgs_t_ls = []; bfgs_iter_ls = [];

for e = e_list
    disp('For General Newton')
    [minimum, duration, iters] = Newton(f,x0,e);
    newton_m_ls = [newton_m_ls, minimum];
    newton_t_ls = [newton_t_ls, duration];
    newton_iter_ls = [newton_iter_ls, iters];

    disp('For BFGS')
    [minimum, duration, iters] = BFGS(f,x0,e);
    bfgs_m_ls = [bfgs_m_ls, minimum];
    bfgs_t_ls = [bfgs_t_ls, duration];
    bfgs_iter_ls = [bfgs_iter_ls, iters];

    disp('For SR1')
    [minimum, duration, iters] = SR1(f,x0,e);
    sr1_m_ls = [sr1_m_ls, minimum];
    sr1_t_ls = [sr1_t_ls, duration];
    sr1_iter_ls = [sr1_iter_ls, iters];
end

figure(1)
plot(e_list, newton_m_ls, e_list, sr1_m_ls, e_list, bfgs_m_ls)
title('N=15')
xlabel('tolerance')
ylabel('minimum achieved')
legend('Newton','SR1', 'BFGS')

figure(2)
plot(e_list, newton_t_ls, e_list, sr1_t_ls, e_list, bfgs_t_ls)
title('N=15')
xlabel('tolerance')
ylabel('cpu time')
legend('Newton','SR1', 'BFGS')

figure(3)
plot(e_list, newton_iter_ls, e_list, sr1_iter_ls, e_list, bfgs_iter_ls)
title('N=15')
xlabel('tolerance')
ylabel('training iterations')
legend('Newton','SR1', 'BFGS')



