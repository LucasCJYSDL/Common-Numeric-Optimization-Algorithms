function func_pp = fpp(x)
func_pp = 2 * sec(vpa(x, 22)).^2 * tan(vpa(x, 22));
end