function [] = comparison(type, type_name, save, simplices, figure_simplices, figure_Betti)
%%Tests the correlation coefficient of the graphs invariants with the
%%simplices_count and Betti numbers. Store the significant one.
matrix = probabilities_from_text(type_name);
probabilities = list_from_matrix(matrix);
nb_p = length(probabilities);
names = {"in degrees", "density", "clustering", "transitivity", "local efficiency", "modularity", "characteristic path", "global efficiency", "betweenness"};
nb_par = length(names);

strong_simplices_correlations = zeros(10, nb_par);
strong_Betti_correlations = zeros(10, nb_par);
linear_coefficient_S = zeros(10, nb_par, nb_p);
intersect_coefficient_S = zeros(10, nb_par, nb_p);
linear_coefficient_B = zeros(10, nb_par, nb_p);
intersect_coefficient_B = zeros(10, nb_par, nb_p);

for i = [1:nb_p]
    p = probabilities(i)
    graphs = graphs_from_data(p, type_name);
    [nb_v, nb_v, nb_sim] = size(graphs);
    degrees_in = []; %On peut vérifier que degree_in = nb_v * p.
    density = []; %density = p?
    clustering = []; %clustering = p?
    transitivity = []; %transitivity = p?
    local_efficiency = [];
    modularity = [];
    characteristic_path = []; %characteristic_path = p?
    global_efficiency = [];
    betweenness = [];
    
    for sim = [1:nb_sim]
        G = graphs(:,:,sim);
        [d_in, dens, clu, t, l_e, m, c_p, g_e, b] = parameters(G);
        degrees_in = [degrees_in, d_in];
        density = [density, dens];
        clustering = [clustering, clu];
        transitivity = [transitivity, t];
        local_efficiency = [local_efficiency, l_e];
        modularity = [modularity, m];
        characteristic_path = [characteristic_path, c_p];
        global_efficiency = [global_efficiency, g_e];
        betweenness = [betweenness, b];
    end
    
    params = zeros(nb_sim, nb_par);
    params(:,1)=degrees_in;
    params(:,2)=density;
    params(:,3)=clustering;
    params(:,4)=transitivity;
    params(:,5)=local_efficiency;
    params(:,6)=modularity;
    params(:,7)=characteristic_path;
    params(:,8)=global_efficiency;
    params(:,9)=betweenness;
    
    [simplices_count, Betti_numbers, dim, nb_Betti] = flagser_results(p, type_name);
    correlations = [];
    
    for N = [1:nb_par]
        param = params(:,N);
        name = names(N);
            
        if simplices || figure_simplices
            for d = [2:dim] %starts at simplices of dim 2
                d_simplices_count = list_from_matrix(simplices_count(:,d));
                r = correlation_coefficient(d_simplices_count, param);
                if abs(r) > 0.5
                    cor = "The number of " + string(d) + "-simplices and " + name + ", with r = " + string(r);
                    correlations = [correlations, cor];
                    
                    if abs(r) > 0.95 && figure_simplices
                        strong_simplices_correlations(d, N) = strong_simplices_correlations(d, N) + 1;
                        param_fig = [ones(length(param),1)  param];
                        b = param_fig\d_simplices_count;
                        linear_coefficient_S(d,N,i) = b(2);
                        intersect_coefficient_S(d,N,i) = b(1);

                        model = b(2) * param + b(1);
                        cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\correlations\" + type_name + "\Linear regression\Simplices counts");
                        fig_name = "p_" + string(p) + "_" + name + "_" + string(d) + "_simplices_count.png";
                        scatter(param,d_simplices_count)
                        hold on
                        plot(param,model)
                        xlabel(name)
                        ylabel(string(d) + " simplices count")
                        title("Linear regression relation between " + name + " & " + string(d) + " simplices count at p = " + string(p))
                        legend(string(d) + " simplices count", 'Linear regression')
                        delete(findall(gcf,'type','annotation'))
                        s = "r = " + string(r) + sprintf('\n') + "slope = " + string(floor(b(2))) + sprintf('\n') + "intersect = " + string(floor(b(1)));
                        annotation('textbox', [0.65, 0.6, 0.25, 0.15], 'String', s)
                        grid on
                        print(fig_name, '-dpng')
                        hold off
                    end
                end
            end
        end
        for nb = [1:nb_Betti]
            Betti_nb = list_from_matrix(Betti_numbers(:,nb));
            r = correlation_coefficient(Betti_nb, param);
            if abs(r) > 0.5
                cor = "Betti " + string(nb) + " and " + name + ", with r = " + string(r);
                correlations = [correlations, cor];
                
                if abs(r) > 0.8 && figure_Betti
                    strong_Betti_correlations(nb, N) = strong_Betti_correlations(nb, N) + 1;
                    param_fig = [ones(length(param),1)  param];
                    b = param_fig\Betti_nb;
                    linear_coefficient_B(nb,N,i) = b(2);
                    intersect_coefficient_B(nb,N,i) = b(1);
                    
                    model = b(2) * param + b(1);
                    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\correlations\" + type_name + "\Linear regression\Betti numbers");
                    fig_name = "p_" + string(p) + "_" + name + "_Betti_" + string(nb) + ".png";
                    scatter(param,Betti_nb)
                    hold on
                    plot(param,model)
                    xlabel(name)
                    ylabel("Betti " + string(nb))
                    title("Linear regression relation between " + name + " & Betti " + string(nb) + " at p = " + string(p))
                    legend("Betti " + string(nb), 'Linear regression')
                    delete(findall(gcf,'type','annotation'))
                    s = "r = " + string(r) + sprintf('\n') + "slope = " + string(floor(b(2))) + sprintf('\n') + "intersect = " + string(floor(b(1)));
                    annotation('textbox', [0.65, 0.6, 0.25, 0.15], 'String', s)
                    grid on
                    print(fig_name, '-dpng')
                    hold off
                end
            end
        end
    end
    
    if save
        filename = "C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\correlations\" + type_name + "\" + type_name + "_p_" + string(p);
        format = ".txt";
        if not(simplices)
            filename = filename + "_only_Betti";
        end
        filename = filename + format;
        t = fopen(filename,'wt');
        fprintf(t,'%s\n\n','Correlations whom abs(r) is higher than 0.5 are between:');
        fprintf(t,'%s\n\n',correlations);
        fclose(t);
    end

end

if figure_simplices
    strong_simplices_correlations; %Erase the ';' if you want the output.
    indices = greater_than_one(strong_simplices_correlations);%At least two points, so that we can draw a line.
    [l c] = size(indices);
    for k = [1:c]
        strong_p = [];
        strong_lin = [];
        strong_inte = [];
        d = indices(1,k);
        N = indices(2,k);
        for i = [1:nb_p]
            if linear_coefficient_S(d, N, i)~=0
                strong_lin = [strong_lin linear_coefficient_S(d, N, i)];
                strong_inte = [strong_inte intersect_coefficient_S(d, N, i)];
                strong_p = [strong_p probabilities(i)];
            end
        end
        cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\correlations\" + type_name + "\Linear coefficients\Simplices counts");
        figure_name = names(N) + "_" + string(d) + "_simplices_count_linear_coefficients.png";
        plot(strong_p, strong_lin)
        hold on
        plot(strong_p, strong_inte)
        xlabel("Probabilities")
        ylabel("Linear coefficients")
        title("Linear coefficients of the relation between " + names(N) + " & " + string(d) + " simplices count")
        delete(findall(gcf,'type','annotation'))
        legend({'Slope coefficient', 'Intersection coefficient'}, 'Location', 'Best')
        print(figure_name, '-dpng')
        hold off
    end
end

if figure_Betti
    strong_Betti_correlations;%Erase the ';' if you want the output.
    indices = greater_than_one(strong_Betti_correlations);%At least two points, so that we can draw a line.
    [l c] = size(indices);
    for k = [1:c]
        strong_p = [];
        strong_lin = [];
        strong_inte = [];
        nb = indices(1,k);
        N = indices(2,k);
        for i = [1:nb_p]
            if linear_coefficient_B(nb, N, i)~=0
                strong_lin = [strong_lin linear_coefficient_B(nb, N, i)];
                strong_inte = [strong_inte intersect_coefficient_B(nb, N, i)];
                strong_p = [strong_p probabilities(i)];
            end
        end
        cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\correlations\" + type_name + "\Linear coefficients\Betti numbers");
        figure_name = names(N) + "_Betti_" + string(nb) + "_linear_coefficients.png";
        plot(strong_p, strong_lin)
        hold on
        plot(strong_p, strong_inte)
        xlabel("Probabilities")
        ylabel("Linear coefficients")
        title("Linear coefficients of the relation between " + names(N) + " & Betti " + string(nb))
        delete(findall(gcf,'type','annotation'))
        legend({'Slope coefficient', 'Intersection coefficient'}, 'Location', 'Best')
        print(figure_name, '-dpng')
        hold off
    end
end
