function [minimum, duration, iters] = SR1(f,start,e)

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
    new_xk = cell2mat(xk) + double((ak*pk)');
    delta_x = (new_xk - cell2mat(xk))';
    new_xk = num2cell(new_xk);
    yk = double(grad(new_xk{:})) - double(grad(xk{:}));
    H = H + (delta_x - H * yk) * (delta_x - H * yk)' / ((delta_x - H * yk)' * yk);

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
min = double(best_solution);
minimum = best_obj;
iters = itt;
fprintf("minimum = %f, itterations needed = %d, cpu_time = %f\n", best_obj, itt, end_time - start_time);
disp(best_solution)
end