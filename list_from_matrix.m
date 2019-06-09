function [l] = list_from_matrix(M)
%%Make the list of a parameter from its matrice.
l = [];
n = size(M);
for i = [1:n]
    l = [l, M(i,1)];
end
l = l.';