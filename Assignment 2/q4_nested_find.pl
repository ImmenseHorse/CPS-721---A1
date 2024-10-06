% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Duke Nguyen
%%%%% NAME: Zehra Cengiz
%%%%% NAME: Simon Aleksandrov
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: nestedLists
%%%%% Put your rules for nestedFindDepth, nestedFindIndex, and any helper predicates below

myMember([X|T],X).
myMember([H|T], X):- myMember(T, X).

nestedFindDepth(L, I, D):- myMember(L, I), D is 0.
nestedFindDepth([H|T], I, D):- is_list(H), nestedFindDepth(H, I, D1), D is D1+1.
nestedFindDepth([H|T], I, D):- nestedFindDepth(T, I, D).

nestedFindIndex([H|T], I, D, Y):- H = I, D is 0, Y is 0.
nestedFindIndex([H|T], I, D, Y):- nestedFindDepth(H, I, D1), D is D1+1, Y is 0.
nestedFindIndex([H|T], I, D, Y):- nestedFindIndex(T, I, D, Y1), Y is Y1+1. 