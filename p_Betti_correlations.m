function [] = p_Betti_correlations(type_name)
%%Compute the correlations between probabilities and Betti numbers averages of the same type
%%of graph.

matrix = probabilities_from_text(type_name);
probabilities = list_from_matrix(matrix);
nb_p = length(probabilities);
average_Betti_numbers = zeros(10,10);

for i = [1:nb_p]
    p = probabilities(i)
    [simplices_count, Betti_numbers, dim, nb_Betti] = flagser_results(p, type_name);
   
    for nb = [1:nb_Betti]
        average_Betti_numbers(i,nb) = mean(Betti_numbers(:,nb));
    end
end

for nb = [1:10]
    avg_Betti_nb = list_from_matrix(average_Betti_numbers(:,nb));
    r = correlation_coefficient(probabilities, avg_Betti_nb);
    if abs(r) > 0.8
        probabilities_fig = [ones(length(probabilities),1)  probabilities];
        b = probabilities_fig\avg_Betti_nb;
        model = b(2) * probabilities + b(1);
        cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\p Betti correlations\" + type_name);
        fig_name = "p_Betti_" + string(nb) + ".png";
        scatter(probabilities, avg_Betti_nb)
        hold on
        plot(probabilities, model)
        xlabel("Probabilities")
        ylabel("Betti " + string(nb))
        title("Linear regression relation between probabilities & Betti " + string(nb))
        legend("Betti " + string(nb), 'Linear regression')
        delete(findall(gcf,'type','annotation'))
        s = "r = " + string(r) + sprintf('\n') + "slope = " + string(floor(b(2))) + sprintf('\n') + "intersect = " + string(floor(b(1)));
        annotation('textbox', [0.6, 0.6, 0.2, 0.15], 'String', s)
        grid on
        print(fig_name, '-dpng')
        hold off
    end
end
