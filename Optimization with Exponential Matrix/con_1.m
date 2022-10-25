function [c, ceq] = con_1(x)
    c = [];
    ceq = sum(x.^2) - 1.0;
end