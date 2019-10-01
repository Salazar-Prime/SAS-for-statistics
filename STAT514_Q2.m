array = ['A' 'A' 'A' 'B' 'B' 'B'];
yield = [3 5 4 3 7 6];
c = perms(array);
c = unique(c,'rows');

for i=1:20
    pos_A(i) = mean(yield(find(c(i,:)=='A')));
    pos_B(i) = mean(yield(find(c(i,:)=='B')));    
end
diff = pos_B - pos_A;
avg(i) = mean(mean(diff));    

avg = sort(avg);
% [an,occ] = unique(avg)

[ii,jj,kk]=unique(avg');
freq=accumarray(kk,1);
out=[ii freq]
out2 = num2cell([pos_A;pos_B;-diff]');
c2 = cellstr(c);
out3 = [c2 out2]
% out3 =  sortrows(out3, 4)
