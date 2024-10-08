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

%%%%% SECTION: listShift
%%%%% Put your rules for listShift and any helper predicates below


% Main predicate
listShift(List, V, List) :-
    mylength(List, Len),
    V >= Len.

listShift(List, V, Result) :-
    mylength(List, Len),
    V < Len,
    split_list(List, V, Front, Back),
    myappend(Back, Front, Result).

% Helper predicate to split the list
split_list(List, N, Front, Back) :-
    split_list_helper(List, N, Front, Back).

split_list_helper(List, 0, nil, List).
split_list_helper(next(Head, Tail), N, next(Head, FrontRest), Back) :-
    N > 0,
    N1 is N - 1,
    split_list_helper(Tail, N1, FrontRest, Back).

% Helper predicate to append two lists
myappend(nil, List, List).
myappend(next(Head, Tail1), List2, next(Head, Result)) :-
    myappend(Tail1, List2, Result).

% Helper predicate to calculate length of a list
mylength(nil, 0).
mylength(next(X, Tail), Len) :-
    mylength(Tail, TailLen),
    Len is TailLen + 1.


