function y=exponential_matrix(a)
a_len=length(a);
matrix_size = (1 + sqrt(1+8*a_len))/ 2.0;
M = zeros(matrix_size,matrix_size);
start_id = 1;
for i=1:matrix_size-1
    end_id = start_id + i - 1;
    M(i+1, 1:i) = a(start_id:end_id);
    start_id = end_id + 1;
end
M = - M + transpose(M);

x=[1];
for i = 2:matrix_size
        x(i) = 0;
end
y = expm(M) * transpose(x);

end