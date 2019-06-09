function [probabilities] = probabilities_from_text(type)
%%Create the list of probabilities of a type of graph, from the text file. 
cd ("C:\Users\X\Documents\EPFL\Topology for neurosciences\Etude invariants\simulations\" + type);
delimiterIn = ' ';
headerlinesIn = 0;
filename = type + ".txt";
probabilities = importdata(filename,delimiterIn,headerlinesIn);