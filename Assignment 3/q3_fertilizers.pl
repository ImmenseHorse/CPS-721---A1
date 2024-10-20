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

%%%%% SECTION: minAndMaxList
%%%%% Below, you should define rules for the predicate "minList(List, M)", 
%%%%% which takes in an input List and finds the minimal element there.
%%%%%
%%%%% You should also define rules for the predicate "maxList(List, M)", 
%%%%% which takes in an input List and finds the maximal element there.
%%%%%
%%%%% If you introduce any other helper predicates for implementing minList
%%%%% and maxList, they should be included in this section.

minList([H | T], M) :- myMin(T, H, M).
myMin([], M, M).
myMin([H | T], M1, M) :- H < M1, myMin(T, H, M).
myMin([H | T], M1, M) :- H > M1, myMin(T, M1, M).

maxList([H | T], M) :- myMax(T, H, M).
myMax([], M, M).
myMax([H | T], M2, M) :- H > M2, myMax(T, H, M).
myMax([H | T], M2, M) :- H < M2, myMax(T, M2, M).

%%%%% SECTION: fertilizersSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than minList, maxList, and their helpers) that you choose to introduce.

% Define the valid heights, yields (number of tomatoes), and weights for the plants
heights([1,2,4,5,7]).       % Possible heights in feet
yields([4,6,9,12,21]).      % Possible yields (number of tomatoes)
weights([3,9,10,14,19]).    % Possible weights in arbitrary units
labels([1,2,3,4,5]).        % Labels for the plants (plant 1 to plant 5)

% Custom implementation to check if an element belongs to a list
myMember(X, [X | Tail]).
myMember(X, [Y | T]) :- myMember(X, T).

% Ensure all elements of a list are distinct
myAllDiff([]).
myAllDiff([H | T]) :- not myMember(H, T), myAllDiff(T).

% Helper predicates to validate if a given value belongs to heights, yields, or weights
height(X) :- heights(H), myMember(X, H).
yield(X) :- yields(Y), myMember(X, Y).
weight(X) :- weights(W), myMember(X, W).

% Plant predicate: a plant is identified by its label (N)
% height (H), yield (T), and weight (W) are not guessed at this stage to avoid unnecessary backtracking
plant(N, H, T, W) :- labels(L), myMember(N, L).

tallest(T) :- heights(H), maxList(H, T).    	% Use maxList to get the maximum height
shortest(S) :- heights(H), minList(H, S).   	% Use minList to get the minimum height
mostTomatoes(M) :- yields(T), maxList(T, M).    % Use maxList to get the maximum yield
fewestTomatoes(F) :- yields(T), minList(T, F).  % Use minList to get the minimum yield
heaviest(H) :- weights(W), maxList(W, H).   	% Use maxList to get the maximum weight
lightest(L) :- weights(W), minList(W, L).   	% Use minList to get the minimum weight


% The constraint ordering in solve(List) is designed to improve efficiency by reducing unnecessary backtracking.
% The key points are as follows:
%
% 1. Height Constraints Applied First:
%    - Heights are distinct and have clear relational constraints (e.g., Plant 1 is taller than Plant 3 by 1 foot, and Plant 5 is twice as tall as Plant 1).
%    - These are introduced early to prune the search space significantly, as they rule out many invalid configurations right away.
%
% 2. Interleaving Yield, Weight, and Fertilizer Constraints:
%    - Yield and weight constraints are tightly linked to fertilizers (e.g., the heaviest weight comes from the egg-shell-fertilized plant, and the tallest plant fertilized with seaweed produces the fewest tomatoes).
%    - These constraints are applied in parallel after some height constraints are established to further reduce possibilities.
%
% 3. Fertilizer Assignments After Heights and Yields:
%    - Fertilizer constraints are checked later once heights, yields, and weights are partially resolved to minimize backtracking.
%    - This ensures that invalid configurations are avoided early without guessing fertilizer assignments.
%
% 4. Global All-Diff Checks Interleaved:
%    - The myAllDiff predicate is used incrementally to check that heights, yields, weights, and fertilizer assignments are distinct.
%    - This prevents invalid configurations from being explored too deeply by catching inconsistencies early.
%
% The goal is to spread out the constraints logically, so invalid configurations are caught as early as possible, reducing the overall computation time.


% The main solver predicate that assigns fertilizers, heights, yields, and weights to the plants
solve([Bone_meal, Compost, Egg_shells, Manure, Seaweed, H1, T1, W1, H2, T2, W2, H3, T3, W3, H4, T4, W4, H5, T5, W5]) :-
    % Find the shortest height, most tomatoes, tallest height, fewest tomatoes, heaviest weight, and lightest weight
    shortest(Shortest),
    mostTomatoes(Most),
    tallest(Tallest),
    fewestTomatoes(Fewest),
    heaviest(Heaviest),
    lightest(Lightest),

    % Ensure the shortest plant did not produce the most tomatoes
    yield(TS),				% TS stands for Tomatoes_Shortest
    not TS = Most,                   	% Ensure the yield of the shortest plant is not the maximum yield
    plant(FS, Shortest, TS, WS),      	% Assign the shortest plant with height Shortest, yield TS, and weight WS

    % Plant 1: Assign height, yield, and weight
    height(H1),
    yield(T1),
    plant(1, H1, T1, W1),

    % Plant 5: It is twice as tall as Plant 1
    H5 is H1 * 2,                    % Plant 5 height is double Plant 1 height
    height(H5),
    plant(5, H5, T5, W5),

    % Plant 3: It is shorter than Plant 1 by 1 foot
    H3 is H1 - 1,                    % Plant 3 height is 1 foot shorter than Plant 1
    height(H3),
    plant(3, H3, T3, W3),

    % Plant 2: It is taller than Plant 4, and Plant 4 is taller than Plant 3
    height(H2),
    height(H4),
    H2 > H4,                         % Plant 2 is taller than Plant 4
    yield(T2),
    plant(2, H2, T2, W2),
    H4 > H3,                         % Plant 4 is taller than Plant 3
    yield(T4),
    plant(4, H4, T4, W4),

    % Ensure all heights are distinct
    myAllDiff([H1, H2, H3, H4, H5]),

    % Bone meal: It is applied to the plant with the lightest weight, and it is not Plant 3, 4, or 5
    plant(Bone_meal, HB, TB, Lightest),
    not myMember(Bone_meal, [3,4,5]),

    % Seaweed: It fertilizes the tallest plant, which has the fewest tomatoes, and it is not Plant 3, 4, or 5
    plant(Seaweed, Tallest, Fewest, WT),		% WT stands for Weight_Tallest
    not myMember(Seaweed, [3,4,5]),

    % The weight of the Seaweed-fertilized plant is not the heaviest
    weight(WT),
    not WT = Heaviest,

    % Assign Compost to another plant
    plant(Compost, HC, TC, WC),

    % Egg shells: The plant fertilized with egg shells produced half as many tomatoes as Plant 1 and the heaviest weight
    yield(Egg_shells_Tomatoes),
    T1 is Egg_shells_Tomatoes * 2,    % Egg-shell plant produced half as many tomatoes as Plant 1
    plant(Egg_shells, HES, Egg_shells_Tomatoes, Heaviest),

    % Manure: It is assigned to another plant, and it produced more weight than Plant 3
    plant(Manure, ManureHeight, ManureTomato, ManureWeight),
    not Manure = 3,

    % Ensure all fertilizers are assigned to distinct plants
    myAllDiff([Bone_meal, Compost, Egg_shells, Manure, Seaweed]),

    % Further yield and weight constraints
    weight(W1),                   % Weight of Plant 1
    weight(WS),                   % Weight of shortest plant
    not WS = Heaviest,            % Ensure shortest plant does not have the heaviest weight
    weight(W3),                   % Weight of Plant 3
    weight(ManureWeight),         % Weight of the plant fertilized with manure
    W3 < ManureWeight,            % Plant 3 weight is less than the Manure-fertilized plant weight
    yield(T3),                    % Yield of Plant 3

    weight(W5),                   % Weight of Plant 5
    not W5 = Heaviest,            % Ensure Plant 5 did not produce the heaviest weight
    yield(T5),                    % Yield of Plant 5
    
    % Ensure all yields are distinct
    myAllDiff([T1, T2, T3, T4, T5]),

    % Weight constraints
    weight(W2), 
    W3 > W2,                      % Plant 3 produced a heavier weight than Plant 2
    weight(W4),                   % Weight of Plant 4

    % Ensure all weights are distinct
    myAllDiff([W1, W2, W3, W4, W5]).


solve_and_print :-
    % Get the CPU time before the computation
    cputime(Start),
    
    % Call the solve function to find a solution
    solve([Bone_meal, Compost, Egg_shells, Manure, Seaweed, H1, T1, W1, H2, T2, W2, H3, T3, W3, H4, T4, W4, H5, T5, W5]),
    
    % Get the CPU time after the computation
    cputime(End),
    
    % Calculate the elapsed time
    TimeTaken is End - Start,

    % Output the results of the computation
    write('Bone-meal is used to fertilize plant '), write(Bone_meal), write('.'), nl,
    write('Compost is used to fertilize plant '), write(Compost), write('.'), nl,
    write('Egg-shells is used to fertilize plant '), write(Egg_shells), write('.'), nl,
    write('Manure is used to fertilize plant '), write(Manure), write('.'), nl,
    write('Seaweed is used to fertilize plant '), write(Seaweed), write('.'), nl, nl,

    write('Plant 1 is '), write(H1), write(' feet tall, yields '), write(T1), write(' tomatoes, weighing '), write(W1), write(' pounds.'), nl,
    write('Plant 2 is '), write(H2), write(' feet tall, yields '), write(T2), write(' tomatoes, weighing '), write(W2), write(' pounds.'), nl,
    write('Plant 3 is '), write(H3), write(' feet tall, yields '), write(T3), write(' tomatoes, weighing '), write(W3), write(' pounds.'), nl,
    write('Plant 4 is '), write(H4), write(' feet tall, yields '), write(T4), write(' tomatoes, weighing '), write(W4), write(' pounds.'), nl,
    write('Plant 5 is '), write(H5), write(' feet tall, yields '), write(T5), write(' tomatoes, weighing '), write(W5), write(' pounds.'), nl, nl,

    % Output the CPU time taken
    % Determine how much computer time the computation takes
    write('Time taken: '), write(TimeTaken), write(' seconds.'), nl.
