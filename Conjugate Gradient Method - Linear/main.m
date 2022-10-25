n_list = [100, 1000, 10000];
conj_t_list = []; inv_t_list = [];

for n = n_list
    C = randn(n);
    B = C'*C;
    I = 0.01*eye(n);
    A = B + I;
    b = randn(n, 1);
    x0 = zeros(n, 1);
    conj_start = cputime;
    x_conj = conjgrad(A, b, x0);
    conj_t = cputime - conj_start;
    conj_t_list = [conj_t_list, conj_t];
    inv_start = cputime;
    x_inv = inv(A) * b;
    inv_t = cputime - inv_start;
    inv_t_list = [inv_t_list, inv_t];
end

figure(1)
plot(n_list, conj_t_list, n_list, inv_t_list);
title('CGM on linear systems')
xlabel('matrix size')
ylabel('cpu time')
legend('CGM', 'INV')






