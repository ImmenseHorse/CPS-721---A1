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

%%%%% SECTION: equalEntries
%%%%% Put your rules for equalEntries below

equalEntries([], [], []).

equalEntries([H|T1], [H|T2], [true|T3]) :- equalEntries(T1, T2, T3).
equalEntries([H|T1], [H1|T2], [false|T3]) :- not H = H1, equalEntries(T1, T2, T3).