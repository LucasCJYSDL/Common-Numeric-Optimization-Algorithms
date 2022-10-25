function [alpha] = BTS(f, xk, dk, alpha0)

param = symvar(f);
grad = gradient(f,param);
rho = 0.5;
c1 = 1e-3;

alpha = alpha0;

while true
    new_xk = cell2mat(xk) + alpha * (dk)';
    new_xk = num2cell(new_xk);
    signal = double(f(new_xk{:})) - double(f(xk{:})) - c1 * alpha * double(grad(xk{:}))' * dk;
    if signal > 0
        alpha = rho * alpha;
    else
        break
    end
end

end