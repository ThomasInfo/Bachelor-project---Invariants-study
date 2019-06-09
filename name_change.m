function [] = name_change(type_name)
%%Changes the names of all the files of a type of graph, in folders
%%"simulations" and "flagser_results".
proba = probabilities_from_text(type_name);
n = length(proba);
for i = [1:n]
    p = proba(i)
    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\simulations\"+type_name+"\"+type_name+"_p_" + string(p))
    d = dir;
    m = length(d);
    for j = [3:m]
        file = char(d(j).name);
        l = length(file);
        indice = find_character(file, "_");
        if l-indice == 6
            number = file(l-5:l-4);
        elseif l-indice == 5
            number = file(l-4);
        end
        file = ".\" + file;
        new_name = ".\" + type_name + "_" + number + ".txt";
        if file ~= new_name
            movefile(file,new_name);
        end
    end
    
    cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\flagser results\"+type_name+"\"+type_name+"_p_" + string(p));
    d = dir;
    m = length(d);
    for j = [3:m]
        file = char(d(j).name);
        l = length(file);
        indice = find_character(file, "_");
        if l-indice == 2
            number = file(l-1:l);
        elseif l-indice == 1
            number = file(l);
        end
        file = ".\" + file;
        new_name = ".\" + type_name + "_" + number;
        if file ~= new_name
            movefile(file,new_name);
        end
    end
end