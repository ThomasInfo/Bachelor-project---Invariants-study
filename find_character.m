function [indice] = find_character(character_chain, character)
%%Finds the last indice of a character in a character chain,
%%the character is expected to be in the character chain.
indice = 0;
n = length(character_chain);
for i = [1:n]
    if character_chain(i) == character
        indice = i;
    end
end