function [r] = correlation_coefficient(X,Y)
%%Compute the correlation coefficient of linearity (Bravais-Pearson)
if (std(X) == 0) || (std(Y) == 0)
    r = 0;
else
    r = corr2(X,Y);
end
    