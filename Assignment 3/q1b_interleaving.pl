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
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: puzzleInterleaving
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce


dig(0). dig(1). dig(2). dig(3). dig(4). dig(5).
dig(5). dig(6). dig(7). dig(8). dig(8). dig(9).

myMember(H, [H|T]).
myMember(X, [H|T]) :- myMember(X, T).

uniqueDig([H]).
uniqueDig([H|T]) :- not myMember(H, T), uniqueDig(T).

% T and J are guessed since they don't depend on other variables for their value. 
% J doesn't get immediately guessed since it isn't used until later on, reducing unnecessary computation
% X and C2 depend on each other so X is guessed since more variables depend on X than C2. 
% Rest of the variables including the carry's are set by arithmetic calculations.
% O and V are calculated last since no variables depend on their values. 
% This solution takes significantly less time to compute since it is only guessing 3 times vs 8 before checking (10^3 vs 10^8 diff permutations).
solve([J,E,T,A,X,L,O,V]) :- dig(T), dig(X),
    E is (T * X) mod 10, C1 is (T * X) // 10, L is (C1 + (E*X)) mod 10,
    C2 is ((E*X) + C1) // 10, dig(J), not J = 0, X is ((X*J) + C2) mod 10, 
    A is ((J*X) + C2) // 10, not A = 0, C3 is (L + T) // 10,
    C4 is (X + E + C3) // 10, L is (J + A + C4) mod 10, O is (X + E + C3) mod 10, 
    V is (L + T) mod 10, uniqueDig([J,E,T,A,X,L,O,V]).



solve_and_print :- solve([J,E,T,A,X,L,O,V]), print(" "), print(" "), print(J), print(E),print(T), nl,
                print("*"), print(" "), print(" "), print(A), print(X), nl,
                print("-"), print("-"),print("-"),print("-"),print("-"), nl,
                print(" "), print(A), print(X), print(L), print(E), nl,
                print("+"), print(J), print(E), print(T), print("."), nl,
                print("-"), print("-"),print("-"),print("-"),print("-"), nl,
                print(" "), print(L), print(O), print(V), print(E), nl.