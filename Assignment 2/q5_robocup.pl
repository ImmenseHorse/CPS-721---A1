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
%%%%% Below you can find the KB given in the assignment PDF. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% Do not put any part of the KB in the robocup section below. That section, should only
%%%%% have statements for the canPass, canScore, and any helper predicates needed for computing those
robot(r1).     robot(r2).     robot(r3).
robot(r4).     robot(r5).     robot(r6).
hasBall(r3).
pathClear(r1, net).    pathClear(r2, r1).    pathClear(r3, r2).
pathClear(r3, net).    pathClear(r3, r1).    pathClear(r3, r4).
pathClear(r4, net).    pathClear(r1, r5).    pathClear(r5, r6).

%%%%% SECTION: robocup
%%%%% Put your rules for canPass, canScore, and any helper predicates below

myMember([X|T],X).
myMember([H|T], X):- myMember(T, X).

pathClSym(R1, R2) :- robot(R1), robot(R2), not ((not pathClear(R1, R2)), (not pathClear(R2, R1))).

canPassHelper(R1, R2, M, [R1,R2], Seen):- 1 =< M, pathClSym(R1, R2).
canPassHelper(R1, R2, M, [R1|P], Seen):- 2 =< M, pathClSym(R1, R), not myMember(Seen, R1), canPassHelper(R, R2, M-1, P, [R1|Seen]), not myMember(P, R1).
canPass(R1, R2, M, P):- canPassHelper(R1, R2, M, P, []).

canScoreHelper(R, M,[X1,X2], Seen):- 1 =< M, X1 = R, X2 = net, pathClear(X1, X2).  
canScoreHelper(R, M, [X1, X2| T], Seen):- 2=< M, pathClSym(X1, X2), not myMember(Seen, X1), canScoreHelper(R, M-1, [X2| T], [X1| Seen]),not myMember([X2|T], X1).

canScore(R, M, [R, net]):- 1 =< M, hasBall(R), pathClear(R, net).
canScore(R, M, [X|P]):- 2 =< M, hasBall(X), pathClear(R, net), canScoreHelper(R, M, [X|P], []), not myMember(P, X).

   