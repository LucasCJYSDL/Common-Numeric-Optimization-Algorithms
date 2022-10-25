function [minimum, duration, iters] = Newton(f,start,e)

start_time = cputime;
xk= num2cell(start);

itt = 1;
param = symvar(f);
grad = gradient(f,param);
dgradv = double(norm(grad(xk{:}),2));

obj_value = double(f(xk{:}));
ak = 1;
fprintf('with ak = %d\n',ak)
best_obj = obj_value;
best_solution = start;

while obj_value>=e & (dgradv >= e)
    H = hessian(f);
    H = H(xk{:});
    pk = double(-((inv(H)))*(grad(xk{:})));
    xk = cell2mat(xk) + double((ak*pk)');
    xk = num2cell(xk);
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
min = xk;
minimum = double(f(xk{:}));
iters = itt;
fprintf("minimum = %f, itterations needed = %d, cpu_time = %f\n", double(f(xk{:})), itt, end_time - start_time);

end