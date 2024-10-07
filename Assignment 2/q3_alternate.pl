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

%%%%% SECTION: alternatePlusMinus
%%%%% Put your rules for alternatePlusMinus and any helper predicates below

alternatePlusMinus([], 0).

alternatePlusMinus([H|T], Sum) :- alternateTracker(T, plus, H, Sum).

alternateTracker([], _, Sum, Sum).

alternateTracker([H|T], plus, Acc, Sum) :- NewAcc is Acc + H, alternateTracker(T, minus, NewAcc, Sum).

alternateTracker([H|T], minus, Acc, Sum) :- NewAcc is Acc - H, alternateTracker(T, plus, NewAcc, Sum).