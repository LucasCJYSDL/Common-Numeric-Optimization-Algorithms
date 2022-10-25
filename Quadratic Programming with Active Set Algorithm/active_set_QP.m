function [x_final,lambda_final] = active_set_QP(G,c,A,b,x_0,W_0, E_set, tolerance)
%% modified based on https://github.com/nhorswill/Active-Set-Method-for-Quadratic-Programming

%% initial params
q=[];
x=[x_0];
W = [W_0];
x_k = x_0;
W_k = W_0;
k = 0;
dims = size(A);
indices = 1:dims(1);
non_negative_set = setdiff(indices, E_set);
stop = 0;

while stop==0
   W_c = setdiff(indices,W_k);
   k=k+1;

   %% solve equality constrained QP
   g_k = G*x_k+c;
   dimens=size(A(W_k,:));
   if isempty(W_k)
       p = quadprog(G,g_k);
   else
       p = quadprog(G,g_k,[],[],A(W_k,:),zeros(dimens(1),1));
   end
   for i=1:length(p)
       if abs(p(i))<tolerance
           p(i)=0;
       end
   end

   %% Case 2
   if any(p ~= 0)
       change=A(W_c,:)*p;
       for k=1:length(change)
           if abs(change(k))<tolerance
               change(k)=0;
           end
       end
       rtindex = find(change < 0);
       newindex = W_c(rtindex);
       small = (b(newindex,:)-A(newindex,:)*x_k)./(A(newindex,:)*p);
       rt = min(small);
       ak = min([1,rt]);

       x_k = x_k+ak*p;
   %% Case 2.1
       if ak==1 
           continue;
       end
   %% Case 2.2
       if (ak~=1)
           j = find(small==rt);
           j=j(1);
           j1 = W_c(j);
           W_k = [W_k, j1];
       end
   end

   %% Case 1
   if all(p==0)
       lambda = linsolve(A(W_k,:)',g_k);
       nn_set = intersect(W_k, non_negative_set);
       lambda_nn = lambda(nn_set, :);
   %% Case 1.2
       if any(lambda_nn<0)
           % j = find(lambda_nn<0);
           [M, I] = min(lambda_nn);
           j1=I(1);
           j1 = nn_set(j1);
           x_k=x_k;
           % W_k(j1) = [];
           W_k = setdiff(W_k, [j1]);
       else
           stop=1;
       end
   end

   %% save and return
   q_k = x_k'*G*x_k/2+c'*x_k;

   x = [x, x_k];
   if isempty(W_k)
       W_m=NaN;
   else
       W_m=W_k;
   end
   W = [W, W_m];
   q = [q, q_k];
end
x_final = x_k;
lambda_final = [];
for i=1:dims(1)
   idx = find(W_k(:)==i);
   if isempty(idx)
       lambda_final = [lambda_final, 0.0];
   else
       lambda_final = [lambda_final, lambda(idx(1))];
   end
end

end