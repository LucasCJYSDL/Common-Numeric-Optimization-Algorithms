function [z] = linearization_quad(x_bar, x, A, b, c, L)
[y, y_grad] = quadfunc(x_bar, A, b, c);
z = y + y_grad'*(x-x_bar) + 0.5 * L * norm(x-x_bar)^2;
end