function [d, d_in, d_out] = degrees(G)
%%Computes the degrees of a graph for each vertices.
n = length(G);
d_in = [];
d_out = [];
d = [];
for i = [1:n]
    d_in = [d_in, nnz(G(:,i))];
    d_out = [d_out, nnz(G(i,:))];
end
d=d_in+d_out;