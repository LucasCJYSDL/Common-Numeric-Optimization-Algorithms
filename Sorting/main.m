n_list = [100, 1000, 10000, 100000, 1000000];
bubble_time_list = [];
merge_time_list = [];

for i = 1:length(n_list)
    n = n_list(i);
    bubble_time = 0.0;
    merge_time = 0.0;
    for j = 1:5
        rand_list = rand([1, n]) * 100.0;
        bubble_start = cputime;
        bubble_sort(rand_list);
        bubble_time = bubble_time + (cputime - bubble_start);

        merge_start = cputime;
        merge_sort(rand_list);
        merge_time = merge_time + (cputime - merge_start);
    end
    bubble_time = bubble_time / 5.0;
    merge_time = merge_time / 5.0;
    bubble_time_list(i) = bubble_time;
    merge_time_list(i) = merge_time;
end

plot(n_list, bubble_time_list, n_list, merge_time_list)
hold on
legend('bubble sort','merge sort')