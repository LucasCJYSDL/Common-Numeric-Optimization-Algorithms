fun=@(x)sin(sum(x));
for n = [10, 20, 30, 40, 50]
    fprintf("Constrained with n=%d\n", n)
    st = cputime;
    x0=[1];
    for i = 2:n
        x0(i) = 0;
    end

    A=[];   
    Aeq=[];
    b=[];
    beq=[];
    lb=[];
    ub=[];
    nonlcon = @con_1;
    x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
    et = cputime;
    disp(x)
    fprintf('obj_func = %f\n', fun(x));
    fprintf('cpu_time = %f\n\n\n\n\n', et-st);
end

fun=@(a)sin(sum(exponential_matrix(a)));
for n = [10, 20, 30, 40, 50]
    fprintf("Unconstrained with n=%d\n", n)
    st = cputime;
    a0 = zeros(n*(n-1)/2, 1);
    a = fminunc(fun, a0);
    x = exponential_matrix(a);
    et = cputime;
    disp(transpose(x))
    fprintf('obj_func = %f\n', fun(a));
    fprintf('cpu_time = %f\n\n\n\n\n', et-st);
end
