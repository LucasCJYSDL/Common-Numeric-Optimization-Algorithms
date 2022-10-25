function [minimum, duration, iters] = Newton(f,start,e)

start_time = cputime;
xk= num2cell(start);

itt = 1;
param = symvar(f);
grad = gradient(f,param);

obj_value = double(f(xk{:}));
ak = 1;
fprintf('with ak = %d\n',ak)
while obj_value>=e
    H = hessian(f);
    H = H(xk{:});
    pk = double(-((inv(H)))*(grad(xk{:})));
    xk = cell2mat(xk) + double((ak*pk)');
    xk = num2cell(xk);
    obj_value = double(f(xk{:}));
    itt = itt+1;
end

end_time = cputime;
duration = end_time - start_time;
min = xk;
minimum = double(f(xk{:}));
iters = itt;
fprintf("minimum = %f, itterations needed = %d, cpu_time = %f\n", double(f(xk{:})), itt, end_time - start_time);

end