function [G] = Erdos_Renyi_graph(nb_v, degree, p, save, name, visualisation, biovisualisation)
%%Creates the adjacency matrix of a random directed graph of nb_v vertices, the probability of an edge between two vertices is p.
%%Creates also the text file name.txt of this graph, formated to be computed
%%by flagser, if save is true.
%%degree is not needed in this program.
G = zeros(nb_v);
format = [];
for i = [1:nb_v]
    for j = [1:i-1]
        if rand()<=p;
            G(i,j) = 1;
            format = [format; i-1 j-1];%indices for Flagser start at 0
        end
    end
    for j = [i+1:nb_v]
        if rand()<=p;
            G(i,j) = 1;
            format = [format; i-1 j-1];
        end
    end
end

if save
    vertices = zeros(1, nb_v);
    t = fopen(name,'w');
    fprintf(t,'%s\n','dim 0:');
    fprintf(t,'%i ',vertices);
    fprintf(t,'\r\n');
    fprintf(t,'%s\n','dim 1:');
    fprintf(t,'%i %i\n',format.');
    fclose(t);
end

if visualisation
    G = digraph(G);
    figure;
    plot(G);
    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Latex\Dessins\graphs\ER");
    fig_name = "ER_p_" + string(p) + ".png";
    title("Erdos-Renyi graph with probability of edge existence p = " + string(p))
    print(fig_name, '-dpng')
end
if biovisualisation
    bg = biograph(G);
    dolayout(bg);
    view(bg);
end

