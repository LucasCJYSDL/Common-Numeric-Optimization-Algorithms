function [minimum, duration, iters] = BFGS(f,start,e, mode)

start_time = cputime;
xk= num2cell(start);

itt = 1;
param = symvar(f);
grad = gradient(f,param);

obj_value = double(f(xk{:}));
ak = 1;
I = eye(length(start));
fprintf('with ak = %d\n',ak)
H = eye(length(start));
dgradv = double(norm(grad(xk{:}),2));

best_obj = obj_value;
best_solution = start;

while (obj_value >= e) & (dgradv >= e)

    pk = - H * double((grad(xk{:})));
    if mode == 0
        new_xk = cell2mat(xk) + double((ak*pk)');
    else
        alpha_k = BTS(f, xk, pk, ak);
        new_xk = cell2mat(xk) + double((alpha_k*pk)');
    end
    delta_x = (new_xk - cell2mat(xk))';
    new_xk = num2cell(new_xk);
    yk = double(grad(new_xk{:})) - double(grad(xk{:}));
    H = (I - delta_x * yk' / (yk' * delta_x)) * H * (I - yk * delta_x' / ...
        (delta_x' * yk)) + delta_x * delta_x' / (yk' * delta_x);

    xk = new_xk;
    obj_value = double(f(xk{:}));
    if obj_value < best_obj
        best_solution = cell2mat(xk);
        best_obj = obj_value;
    end

    itt = itt+1;
    dgradv = double(norm(grad(xk{:}),2));
end

end_time = cputime;
duration = end_time - start_time;
min = best_solution;
minimum = best_obj;
iters = itt;
fprintf("minimum = %f, itterations needed = %d, cpu_time = %f\n", best_obj, itt, end_time - start_time);

end