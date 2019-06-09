function [] = ploting(type_of_graph);
probabilities_a = [0:0.01:0.1];
probabilities_b = [0.2:0.1:1];
probabilities = [probabilities_a probabilities_b];
degree = [2 10];

for d = degree
    for p = probabilities
        type_of_graph(100, d, p, false, "None", true, false);
    end
end