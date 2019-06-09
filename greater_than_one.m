function [indices] = greater_than_one(M)
%%Finds the indices of element stricty greater than 1 in the matrix M.
[n m] = size(M);
indices = [];
for i = [1:n]
    for j = [1:m]
        if M(i,j)>1
            indices = [indices [i;j]];
        end
    end
end

        