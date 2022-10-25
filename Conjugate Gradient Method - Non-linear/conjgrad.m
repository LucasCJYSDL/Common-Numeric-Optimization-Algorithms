function [minimum, duration, iters] = conjgrad(f, start, e)
    start_time = cputime;
    xk= num2cell(start);
    itt = 1;
    param = symvar(f);
    grad = gradient(f,param);
    dgradv = double(norm(grad(xk{:}),2));
    
    obj_value = double(f(xk{:}));
    ak = 1;
    best_obj = obj_value;
    best_solution = start;

    r = - double((grad(xk{:})));
    pk = r;
    rsold = r' * r;

    while (obj_value >= e) & (dgradv >= e)
        if mod(itt, length(start)) == 1
            pk = r;
        end

        alpha_k = BTS(f, xk, pk, ak);
        xk = cell2mat(xk) + double((alpha_k*pk)');
        xk = num2cell(xk);
        r = - double((grad(xk{:})));
        rsnew = r' * r;
        pk = r + (rsnew / rsold) * pk;
        rsold = rsnew;

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