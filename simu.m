function [graphs] = simu(graph_type, nb_v, degree, nb_sim, nb_p, save, type_name)
%%Creates nb_p groups of nb_sim random graphs, with nb_v vertices.
%%The results are the text files and a list "graphs" of the nb_sim graphs
%%of the last probability p.
%%Don't forget the @ in front of the first argument.
graphs = zeros(nb_v, nb_v, nb_sim);
path = ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\simulations\"+type_name);
for i = [1:nb_p]
        p = rand();
        if save
            new_folder = type_name+"_p_"+string(p);
            mkdir(fullfile(path, new_folder))
        end
        
        for j = [1:nb_sim]
            if save
                name = path + ("\" + new_folder) + ("\" + type_name + "_" + string(j) + ".txt");
                G = graph_type(nb_v, degree, p, true, name, false, false);
                graphs(:, :, j) = G;
            else
                G = graph_type(nb_v, degree, p, false, "no", false, false);
                graphs(:, :, j) = G;
            end
        end
end