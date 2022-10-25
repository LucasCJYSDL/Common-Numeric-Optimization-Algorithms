t_list = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
init_x = 0.0;
x = init_x;
for t = t_list
    x = Newton(x, t, init_x);
end
fprintf('The solution is %.10f, with objective function %.10f', x, fn(x)); 
