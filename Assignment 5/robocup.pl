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

%%%%% SECTION: robocup_setup
%%%%%
%%%%% These lines allow you to write statements for a predicate that are not consecutive in your program
%%%%% Doing so enables the specification of an initial state in another file
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
:- dynamic hasBall/2.
:- dynamic robotLoc/4.
:- dynamic scored/1.

%%%%% This line loads the generic planner code from the file "planner.pl"
%%%%% Just ensure that that the planner.pl file is in the same directory as this one
:- [planner].

%%%%% SECTION: init_robocup
%%%%% Loads the initial state from either robocupInit1.pl or robocupInit2.pl
%%%%% Just leave whichever one uncommented that you want to test on
%%%%% NOTE, you can only uncomment one at a time
%%%%% HINT: You can create other files with other initial states to more easily test individual actions
%%%%%       To do so, just replace the line below with one loading in the file with your initial state
:- [robocupInit1].
%:- [robocupInit2].

%%%%% SECTION: goal_states_robocup
%%%%% Below we define different goal states, each with a different ID
%%%%% HINT: It may be useful to define "easier" goals when starting your program or when debugging
%%%%%       You can do so by adding more goal states below
%%%%% Goal XY should be read as goal Y for problem X

%% Goal states for robocupInit1
goal_state(11, S) :- robotLoc(r1, 0, 1, S).
goal_state(12, S) :- hasBall(r2, S).
goal_state(13, S) :- hasBall(r3, S).
goal_state(14, S) :- scored(S). 
goal_state(15, S) :- robotLoc(r1, 2, 2, S).
goal_state(16, S) :- robotLoc(r1, 3, 2, S).

%% Goal states for robocupInit1
goal_state(21, S) :- scored(S). 
goal_state(22, S) :- robotLoc(r1, 2, 4, S).

%%%%% SECTION: precondition_axioms_robocup
%%%%% Write precondition axioms for all actions in your domain. Recall that to avoid
%%%%% potential problems with negation in Prolog, you should not start bodies of your
%%%%% rules with negated predicates. Make sure that all variables in a predicate 
%%%%% are instantiated by constants before you apply negation to the predicate that 
%%%%% mentions these variables. 

% Preconditions for move(Robot, Row1, Col1, Row2, Col2)
poss(move(Robot, Row1, Col1, Row2, Col2), S) :-
    robot(Robot), % Robot is valid
    robotLoc(Robot, Row1, Col1, S), % Robot starts at (Row1, Col1)
    valid_adjacent(Row1, Col1, Row2, Col2), % Move is adjacent
    within_bounds(Row2, Col2), % Destination is within bounds
    not(opponentAt(Row2, Col2)), % Destination is not occupied by an opponent
    not(robotLoc(_, Row2, Col2, S)). % Destination is not occupied by any robot

% Preconditions for pass(Robot1, Robot2)
poss(pass(Robot1, Robot2), S) :-
    robot(Robot1), robot(Robot2), not Robot1 = Robot2, % Two distinct robots
    hasBall(Robot1, S), % Robot1 must have the ball
    robotLoc(Robot1, Row1, Col1, S), % Robot1's location
    robotLoc(Robot2, Row2, Col2, S), % Robot2's location
    aligned(Row1, Col1, Row2, Col2), % Pass is horizontal or vertical
    clear_pass_path(Row1, Col1, Row2, Col2). % Path is clear

% Preconditions for shoot(Robot)
poss(shoot(Robot), S) :-
    robot(Robot),
    hasBall(Robot, S), % Robot must have the ball
    robotLoc(Robot, Row, Col, S), % Robot's location
    goalCol(Col), % Robot is in the goal column
    clear_shot_path(Row, Col). % Path to the goal is clear


% Helper predicates

my_abs(Number, AbsoluteValue) :-
    Number >= 0, 
    AbsoluteValue = Number.

my_abs(Number, AbsoluteValue) :-
    Number < 0,
    AbsoluteValue is -Number.

% Ensure the robot moves exactly one step horizontally or vertically.
valid_adjacent(Row1, Col1, Row2, Col2) :-
    my_abs(Row1 - Row2, AbsRowDiff),
    my_abs(Col1 - Col2, AbsColDiff),
    1 is AbsRowDiff + AbsColDiff.

% Check that the destination is within the grid.
within_bounds(Row, Col) :-
    numRows(MaxRows), numCols(MaxCols),
    Row >= 0, Row < MaxRows,
    Col >= 0, Col < MaxCols.

% Ensure the pass is along a straight line (horizontal or vertical).
aligned(Row1, _, Row2, _) :- Row1 = Row2.
aligned(_, Col1, _, Col2) :- Col1 = Col2.

% Ensure no opponents block the passing path.
% Horizontal pass
clear_pass_path(Row1, Col1, Row2, Col2) :-
    Row1 = Row2, % Same row
    between_cols(Col1, Col2, Col), % Check all intermediate columns
    not opponentAt(Row1, Col).

% Vertical pass
clear_pass_path(Row1, Col1, Row2, Col2) :-
    Col1 = Col2, % Same column
    between_rows(Row1, Row2, Row), % Check all intermediate rows
    not opponentAt(Row, Col1).

% Ensure no opponents block the shot to the goal
clear_shot_path(Row, Col) :-
    numRows(MaxRows),
    between_rows(0, Row, BlockRow), not opponentAt(BlockRow, Col).

% Handle intermediate positions along a line (horizontal or vertical).
% Horizontal check for columns
between_cols(Col1, Col2, Col) :-
    Col1 =< Col2, between(Col1, Col2, Col).
between_cols(Col1, Col2, Col) :-
    Col1 > Col2, between(Col2, Col1, Col).

% Vertical check for rows
between_rows(Row1, Row2, Row) :-
    Row1 =< Row2, between(Row1, Row2, Row).
between_rows(Row1, Row2, Row) :-
    Row1 > Row2, between(Row2, Row1, Row).


%%%%% SECTION: successor_state_axioms_robocup
%%%%% Write successor-state axioms that characterize how the truth value of all 
%%%%% fluents change from the current situation S to the next situation [A | S]. 
%%%%% You will need two types of rules for each fluent: 
%%%%% 	(a) rules that characterize when a fluent becomes true in the next situation 
%%%%%	as a result of the last action, and
%%%%%	(b) rules that characterize when a fluent remains true in the next situation,
%%%%%	unless the most recent action changes it to false.
%%%%% When you write successor state axioms, you can sometimes start bodies of rules 
%%%%% with negation of a predicate, e.g., with negation of equality. This can help 
%%%%% to make them a bit more efficient.
%%%%%
%%%%% Write your successor state rules here: you have to write brief comments %




%%%%% SECTION: declarative_heuristics_robocup
%%%%% The predicate useless(A,ListOfPastActions) is true if an action A is useless
%%%%% given the list of previously performed actions. The predicate useless(A,ListOfPastActions)
%%%%% helps to solve the planning problem by providing declarative heuristics to 
%%%%% the planner. If this predicate is correctly defined using a few rules, then it 
%%%%% helps to speed-up the search that your program is doing to find a list of actions
%%%%% that solves a planning problem. Write as many rules that define this predicate
%%%%% as you can: think about useless repetitions you would like to avoid, and about 
%%%%% order of execution (i.e., use common sense properties of the application domain). 
%%%%% Your rules have to be general enough to be applicable to any problem in your domain,
%%%%% in other words, they have to help in solving a planning problem for any instance
%%%%% (i.e., any initial and goal states).
%%%%%	
%%%%% write your rules implementing the predicate  useless(Action,History) here. %



