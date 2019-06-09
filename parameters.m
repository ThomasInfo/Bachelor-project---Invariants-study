function [avg_degree_in, kden, avg_cluster, transi, local_efficiency, avg_modularity, characteristic_path, global_efficiency, avg_betweenness_centrality] = parameters(G)
%%Compute all the graphs invariants, if the parameter is local (for each
%%vertex), we take the average.
%Degree.
[d, d_in, d_out] = degrees(G);
avg_degree_in = mean(d_in); %avg_degree_out is the same, so globally as a graph, there is no need of degree_out, neither of degree.
std_degree_in = std(d_in);

%Physical connectivity.
[kden, N, K] = density_dir(G);

%Clustering.
coefs = clustering_coef_bd(G);
avg_cluster = mean(coefs);
std_cluster = std(coefs);

transi = transitivity_bd(G);

%Efficiency.
local_efficiency = efficiency_bin(G);

%Community.
%Avg actually not needed.
m = modularity_dir(G);
avg_modularity = mean(m);
std_modularity = std(m);

%Distance.
[characteristic_path,global_efficiency] = charpath(G);

%Centrality.
b = betweenness_bin(G);
avg_betweenness_centrality = mean(b);
std_betweenness_centrality = std(b);


