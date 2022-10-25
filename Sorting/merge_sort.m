function result=merge_sort(num_array)
N=length(num_array);

if floor(N/2)>=2
   sub_sorted_l=merge_sort(num_array(1:floor(N/2)));
   sub_sorted_r=merge_sort(num_array(floor(N/2)+1:N));
       
else 
   sub_sorted_l=num_array(1);
   sub_sorted_r=num_array(2:end);
   if length(sub_sorted_r)>1 
       if sub_sorted_r(1)>sub_sorted_r(2)
           sub_sorted_r([1 2])=sub_sorted_r([2 1]);
       end
   end
end
   
kl=1;   % index for sub_sorted_l
kr=1;   % index for sub_sorted_r
k=1;    % index for result
while kl<=length(sub_sorted_l) && kr<=length(sub_sorted_r)
   if sub_sorted_l(kl)<sub_sorted_r(kr)   % ascending sort
       result(k)=sub_sorted_l(kl);   % result(k)
       kl=kl+1;
   else
       result(k)=sub_sorted_r(kr);
       kr=kr+1;
   end
   k=k+1;
end
% after one sub array is exhausted, put the rest of the other into the result
if kl>length(sub_sorted_l)
   for ki=0:(length(sub_sorted_r)-kr)
       result(k+ki)=sub_sorted_r(kr+ki);
   end
elseif kr>length(sub_sorted_r)
   for ki=0:(length(sub_sorted_l)-kl)
       result(k+ki)=sub_sorted_l(kl+ki);
   end
end