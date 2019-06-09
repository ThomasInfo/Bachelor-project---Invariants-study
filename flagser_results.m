function [simplices_count, Betti_numbers, dim, nb_Betti] = flagser_results(p, type_name)
%%Extracts the simplices_counts, the Betti numbers and the size of each from
%%the resulting text file created by flagser.
cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\flagser results\" + type_name + "\" + type_name + "_p_" + string(p));
nb_sim = length(ls) - 2;
filename = type_name + "_1";
delimiterIn = ' ';

headerlinesIn_simplices = 1;
simplices_data = importdata(filename,delimiterIn,headerlinesIn_simplices);
dimensions = size(simplices_data.data);
dim = dimensions(2);

headerlinesIn_Betti = 3;
Betti_data = importdata(filename,delimiterIn,headerlinesIn_Betti);
dimensions = size(Betti_data.data);
nb_Betti = dimensions(2);

simplices_count = zeros(nb_sim, dim);
Betti_numbers = zeros(nb_sim, nb_Betti);


for sim = [1:nb_sim]
    filename = type_name + "_" + string(sim);

    simplices_data = importdata(filename,delimiterIn,headerlinesIn_simplices);
    s = size(simplices_data.data);
    limit = s(2);
    simplices_count(sim,1:limit) = simplices_data.data;

    Betti_data = importdata(filename,delimiterIn,headerlinesIn_Betti);
    s = size(Betti_data.data);
    limit = s(2);
    Betti_numbers(sim,1:limit) = Betti_data.data;
end
