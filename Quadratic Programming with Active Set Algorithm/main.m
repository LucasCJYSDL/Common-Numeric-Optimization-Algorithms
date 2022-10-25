syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 l1 l2

f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) = tan(x1.^2 + x2.^2 + x3.^2 ...
    + x4.^2 + x5.^2 + x6.^2 + x7.^2 + x8.^2 + x9.^2 + x10.^2);

g1(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) = (x1 - x2 + x3 - x4 + x5 - x6 + x7 - x8 + x9 - x10);

g2(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) = x1.^2 + 1./2 * x2.^2 + 1./3 * x3.^2 ...
+ 1./4 * x4.^2 + 1./5 * x5.^2 + 1./6 * x6.^2 + 1./7 * x7.^2 + 1./8 * x8.^2 + 1./9 * x9.^2 + 1./10 * x10.^2 - 1.;

L(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, l1, l2) = tan(x1.^2 + x2.^2 + x3.^2 ...
    + x4.^2 + x5.^2 + x6.^2 + x7.^2 + x8.^2 + x9.^2 + x10.^2) ...
    + l1 * (x1 - x2 + x3 - x4 + x5 - x6 + x7 - x8 + x9 - x10) ...
    + l2 * (x1.^2 + 1./2 * x2.^2 + 1./3 * x3.^2 + 1./4 * x4.^2 + 1./5 * x5.^2 ...
           + 1./6 * x6.^2 + 1./7 * x7.^2 + 1./8 * x8.^2 + 1./9 * x9.^2 + 1./10 * x10.^2 - 1.);

x0 = [1.0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
l0 = [1, 1]; 
lp_f = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

itt = 1;
tolerance = 1e-10;

xk= num2cell(x0);
lk = num2cell(l0);
param = symvar(f);
grad = gradient(f, param);
grad_L = gradient(L, param);
grad_g1 = gradient(g1, param);
grad_g2 = gradient(g2, param);
hess = hessian(L, param);
h_input = [xk, lk];
dgradv = double(norm(grad_L(h_input{:}),2));

while dgradv >= tolerance
    h_input = [xk, lk];
    Hk = hess(h_input{:});
    gfk = grad(xk{:});
    
    Q = double(Hk);
    b = double(gfk);
    A = double(grad_g1(xk{:}))';
    c = -double(g1(xk{:}));
    W = double(grad_g2(xk{:}))';
    v = -double(g2(xk{:}));

    qp_x0 = linprog(lp_f, W, v, A, c);
    qp_x0_cell = num2cell(qp_x0);
    if abs(double(g2(qp_x0_cell{:}))) < tolerance
        qp_w0 = [1, 2];
    else
        qp_w0 = [1];
    end
    [dk, lk] = active_set_QP(Q, b, [A; -W], [c; -v], qp_x0, qp_w0, [1], tolerance);

    xk = num2cell(cell2mat(xk) + dk');
    lk = num2cell(lk);

    double(f(xk{:}))

    itt = itt + 1;
    h_input = [xk, lk];
    dgradv = double(norm(grad_L(h_input{:}),2));
%     dgradv = double(norm(grad(xk{:}),2));
end








