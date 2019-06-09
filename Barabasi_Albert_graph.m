function [G] = Barabasi_Albert_graph(nb_v, degree, p, save, name, visualisation, biovisualisation)
%%Creates the adjacency matrix of a preferential attachment type undirected graph with Barabasi-Albert algorithm.
%%It starts with 'degree' vertices and grows up to nb_v vertices.
%%When one vertex is added, 'm' edges are created between it and 'm' other
%%existing vertices, according to preferential attachment.
%%Creates also the text file name.txt of this graph, formated to be computed
%%by flagser, if save is true.
G = zeros(nb_v);
m = floor(p * degree);%m is the number of edges to be created between every new vertices and existent ones. m < degree is respected.
attachment = [1:degree];
format = [];
for i = [degree+1:nb_v]
    l = length(attachment);
    neighbours = [];
    while nnz(G(i,:)) < m
        r = randi(l);
        v = attachment(r);
        while G(i,v) == 1
            r = randi(l);
            v = attachment(r);
        end
        G(i,v)=1;
        G(v,i)=1;
        neighbours = [neighbours i v];
        format = [format; i-1 v-1];
    attachment = [attachment neighbours];
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
    G = graph(G);
    figure;
    plot(G);
    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Latex\Dessins\graphs\BA");
    fig_name = "BA_p_" + string(p) + ".png";
    title("Barabasi-Albert graph with " + string(degree) + " initial vertices and " + string(m) + " added edges")
    print(fig_name, '-dpng')
end
if biovisualisation
    bg = biograph(G);
    dolayout(bg);
    view(bg);
end
