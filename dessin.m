function G = dessin(nb_v, sources, sinks, weights, node_labels, edge_labels, dir, two_D, fill_space, save, name);
%%Draws the graph plots for the report.
figure
G_dir = digraph(sources, sinks, weights);
G = graph(sources, sinks, weights);

if fill_space
    M = zeros(nb_v);
    nb_s = length(sources);
    for i = [1:nb_s]
        source = sources(i);
        sink = sinks(i);
        M(source, sink) = 1;
        M(sink, source) = 1;
    end
    
    if two_D
        if length(node_labels) > 0
            p = plot(G, 'NodeLabel', node_labels, 'EdgeLabel', edge_labels)
        else
            p = plot(G)
        end
        hold on
        p_dir = plot(G_dir)
    else
        if length(node_labels) > 0
            p = plot(G, 'Layout', 'force3', 'NodeLabel', node_labels, 'EdgeLabel', edge_labels)
        else
            p = plot(G, 'Layout', 'force3')
        end
        hold on
        p_dir = plot(G_dir, 'Layout', 'force3')
    end
    p.NodeFontSize = 15;
    p.EdgeFontSize = 15;
    p_dir.NodeFontSize = 15;
    p_dir.EdgeFontSize = 15;
    if not(two_D)
        layout(p,'force3','WeightEffect','direct')
        layout(p_dir,'force3','WeightEffect','direct')
    end
    hold on

    X = p.XData;
    Y = p.YData;
    Z = p.ZData;
    for i = [1:nb_s]
        source = sources(i);
        sink = sinks(i);
        for j = [1:nb_v]
            if M(sink, j)==1 && M(j, source)==1
                x = [X(source), X(sink), X(j)];
                y = [Y(source), Y(sink), Y(j)];
                z = [Z(source), Z(sink), Z(j)];
                fill3(x, y, z, [0 0.7 0.9]);
            end
        end
    end
end

if two_D
    if length(node_labels) > 0
        p = plot(G, 'NodeLabel', node_labels, 'EdgeLabel', edge_labels)
    else
        p = plot(G)
    end
    hold on
    p_dir = plot(G_dir)
else
    if length(node_labels) > 0
        p = plot(G, 'Layout', 'force3', 'NodeLabel', node_labels, 'EdgeLabel', edge_labels)
    else
        p = plot(G, 'Layout', 'force3')
    end
    hold on
    p_dir = plot(G_dir, 'Layout', 'force3')
end
p.NodeColor = 'k';
p_dir.NodeColor = 'k';
p.NodeFontSize = 15;
p_dir.NodeFontSize = 15;
p.NodeFontWeight = 'bold';
p_dir.NodeFontWeight = 'bold';
p.EdgeColor = 'b';
p_dir.EdgeColor = 'k';
p_dir.LineWidth = 0.01;
p_dir.EdgeAlpha = 1;
p.EdgeFontSize = 15;
p_dir.EdgeFontSize = 15;
p.EdgeFontWeight = 'bold';
p_dir.EdgeFontWeight = 'bold';
p.LineWidth = 3;
if not(two_D)
    layout(p,'force3','WeightEffect','direct')
    layout(p_dir,'force3','WeightEffect','direct')
end

if dir
    p_dir.ShowArrows = 'on';
    p_dir.ArrowSize = 20;
else
    p_dir.ShowArrows = 'off';
end

set(gca,'xtick',[],'ytick',[])
hold off

cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Latex\Dessins");
print(name, '-dpng')