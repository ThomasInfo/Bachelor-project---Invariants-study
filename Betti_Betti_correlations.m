function [] = Betti_Betti_correlations(type_name, save, figure)
%%Compute the correlations between different Betti numbers of the same type
%%of graph.

matrix = probabilities_from_text(type_name);
probabilities = list_from_matrix(matrix);
nb_p = length(probabilities);

for i = [1:nb_p]
    p = probabilities(i)
    [simplices_count, Betti_numbers, dim, nb_Betti] = flagser_results(p, type_name);
    correlations = [];
            
    for nb_1 = [1:nb_Betti]
        for nb_2 = [nb_1+1:nb_Betti]
            Betti_nb_1 = list_from_matrix(Betti_numbers(:,nb_1));
            Betti_nb_2 = list_from_matrix(Betti_numbers(:,nb_2));
            r = correlation_coefficient(Betti_nb_1, Betti_nb_2);
            if abs(r) > 0.5
                cor = "Betti " + string(nb_1) + " and Betti " + string(nb_2) + ", with r = " + string(r);
                correlations = [correlations, cor];
                if abs(r) > 0.8 && figure
                    Betti_nb_1_fig = [ones(length(Betti_nb_1),1)  Betti_nb_1];
                    b = Betti_nb_1_fig\Betti_nb_2;
                    %linear_coefficient = b(2);
                    %intersect_coefficient = b(1);

                    model = b(2) * Betti_nb_1 + b(1);
                    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\between Betti correlations\" + type_name + "\Linear regression");
                    fig_name = "p_" + string(p) + "_Betti_" + string(nb_1) + "_Betti_" + string(nb_2) + ".png";
                    scatter(Betti_nb_1,Betti_nb_2)
                    hold on
                    plot(Betti_nb_1,model)
                    xlabel("Betti " + string(nb_1))
                    ylabel("Betti " + string(nb_2))
                    title("Linear regression relation between Betti " + string(nb_1) + " & Betti " + string(nb_2) + " at p = " + string(p))
                    legend("Betti " + string(nb_2), 'Linear regression')
                    delete(findall(gcf,'type','annotation'))
                    s = "r = " + string(r) + sprintf('\n') + "slope = " + string(floor(b(2))) + sprintf('\n') + "intersect = " + string(floor(b(1)));
                    annotation('textbox', [0.6, 0.6, 0.2, 0.15], 'String', s)
                    grid on
                    print(fig_name, '-dpng')
                    hold off
                end
            end
        end
    end
    
    if save
        filename = "C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\between Betti correlations\" + type_name + "\" + type_name + "_p_" + string(p);
        format = ".txt";
        filename = filename + format;
        t = fopen(filename,'wt');
        fprintf(t,'%s\n\n','Correlations whom abs(r) is higher than 0.5 are between:');
        fprintf(t,'%s\n\n',correlations);
        fclose(t);
    end

end

% if figure
%     strong_Betti_correlations;%Erase the ';' if you want the output.
%     indices = greater_than_one(strong_Betti_correlations);%At least two points, so that we can draw a line.
%     [l c] = size(indices);
%     for k = [1:c]
%         strong_p = [];
%         strong_lin = [];
%         strong_inte = [];
%         nb = indices(1,k);
%         N = indices(2,k);
%         for i = [1:nb_p]
%             if linear_coefficient(nb, N, i)~=0
%                 strong_lin = [strong_lin linear_coefficient(nb, N, i)];
%                 strong_inte = [strong_inte intersect_coefficient(nb, N, i)];
%                 strong_p = [strong_p probabilities(i)];
%             end
%         end
%         cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\correlations\" + type_name + "\Linear coefficients");
%         figure_name = names(N) + "_Betti_" + string(nb) + "_linear_coefficients.png";
%         plot(strong_p, strong_lin)
%         hold on
%         plot(strong_p, strong_inte)
%         xlabel("Probabilities")
%         ylabel("Linear coefficients")
%         title("Linear coefficients of the relation between " + name + " & Betti " + string(nb))
%         delete(findall(gcf,'type','annotation'))
%         legend({'Slope coefficient', 'Intersection coefficient'}, 'Location', 'Best')
%         print(figure_name, '-dpng')
%         hold off
%     end
% end
