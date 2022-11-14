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

x0 = [0.0; 2.0];
t0 = 4.5;
ka = 0.25;
mu = 1.0;
L = 20.0;
beta = (sqrt(L) - sqrt(mu))/(sqrt(L) + sqrt(mu));
epsilon = 1e-4;

tk = t0;
xk = x0;
k = 0;

yk = xk;
ls = [];
func_k = @(x)[linearization_quad(yk, x, A0, b0, c0, L)-tk, 
              linearization_quad(yk, x, A1, b1, c1, L),
              linearization_quad(yk, x, A2, b2, c2, L),
              linearization_quad(yk, x, A3, b3, c3, L)];
xk = fminimax(func_k, xk, [], [], [], [], lb, ub);
ls = [ls, xk];
ls = [ls, xk]
disp(xk);