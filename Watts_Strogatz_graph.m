function [G] = Watts_Strogatz_graph(nb_v, mean_degree, p, save, name, visualisation, biovisualisation)
%%Constructs a small-world undirected graph with Watts-Strogatz algorithm.
%%degree is the mean degree, p is the probability of rewiring.
%%Check degree is even and ln(nb_v) << degree << nb_v.
%%For now we choose mean_degree = nb_v/10.
%%Check also degree, clustering coefficient and average path length.
G = zeros(nb_v);
format = [];
h=mean_degree/2;
for i = [1:nb_v]
    for j = [i+1:nb_v]
        diff = mod(abs(i-j),nb_v-h);
        if diff>0 && diff<=h;
            G(i,j) = 1;
            G(j,i) = 1;
        end
    end
end
for i = [1:nb_v]
    for j = [i+1:i+h]
        j = mod(j,nb_v)+1;%indices start at 1
        if rand()<=p
            k = randi([1 nb_v]);
            while k==i || G(i,k)==1
                k = randi([1 nb_v]);
            end
            G(i,j) = 0;
            G(j,i) = 0;
            G(i,k) = 1;
            G(k,i) = 1;
        end
    end
end

for i = [1:nb_v]
    for j = [1:nb_v]
        if G(i,j) == 1
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
    G = graph(G);
    figure;
    plot(G);
    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Latex\Dessins\graphs\WS");
    fig_name = "WS_d_" + string(mean_degree) + "_p_" + string(p) + ".png";
    title("Watts-Strogatz graph with " + string(mean_degree) + " neighbours and a rewiring probability of p = " + string(p))
    print(fig_name, '-dpng')
end
if biovisualisation
    bg = biograph(G);
    dolayout(bg);
    view(bg);
end
