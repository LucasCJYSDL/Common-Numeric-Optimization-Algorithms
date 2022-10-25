function func_ppp = fppp(x)
func_ppp = -4 * sec(vpa(x, 22)).^2 + 6 * sec(vpa(x, 22)).^4;
end