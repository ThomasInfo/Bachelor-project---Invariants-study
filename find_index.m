function [j] = find_index(l, i)
%%Find the first index of the number i in the list (vector) l. i must be in
%%l.
n = length(l);
j=1;
while j<=n && l[j]~=i
    j = j+1;
end
        