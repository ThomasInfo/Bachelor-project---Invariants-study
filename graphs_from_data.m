function [graphs] = graphs_from_data(p, type_name)
%%Creates the adjacency matrix of a graph from its text file.
cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\simulations\" + type_name + "\" + type_name + "_p_" + string(p));
nb_sim = length(ls) - 2; 
delimiterIn = ' ';
headerlinesIn_vertices = 1;
headerlinesIn_edges = 3;
filename = type_name + "_1.txt";
vertices_data = importdata(filename,delimiterIn,headerlinesIn_vertices);
nb_v = length(vertices_data.data);

graphs = zeros(nb_v, nb_v, nb_sim);

for sim = [1:nb_sim]
    filename = type_name + "_" + string(sim) + ".txt";
    edges_data = importdata(filename,delimiterIn,headerlinesIn_edges);
    edges = edges_data.data;
    dimensions = size(edges);
    nb_edges = dimensions(1);

    G = zeros(nb_v);
    for k = [1:nb_edges]
        i = edges(k, 1);
        j = edges(k, 2);
        G(i+1,j+1)=1;
    end

    graphs(:,:,sim) = G;
end

    