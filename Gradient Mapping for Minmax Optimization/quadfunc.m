function [y, y_grad] = quadfunc(x,A,b,c)
y = 1/2*x'*A*x + b'*x + c;
y_grad = A*x + b;
end