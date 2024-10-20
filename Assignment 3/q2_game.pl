% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%% NAME: Duke Nguyen
%%%%% NAME: Zehra Cengiz
%%%%% NAME: Simon Aleksandrov
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: fourExactly
%%%%% Below, you should define rules for the predicate "fourExactly(X,List)", 
%%%%% which takes in an input List and checks whether there are exactly 4 
%%%%% occurrences of a given element X in the list.
%%%%%
%%%%% If you introduce any other helper predicates for implementing fourExactly,
%%%%% they should be included in this section.
% fourExactly predicate
fourExactly(X, List) :- count(X, List, 4).

% count predicate
count(_, [], 0).
count(X, [X|T], N) :- count(X, T, N1), N is N1 + 1.
count(X, [Y|T], N) :- X \= Y, count(X, T, N).

%%%%% SECTION: gameSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%solve_and_print :-
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than fourExactly and its helpers) that you choose to introduce.

% Define the teams participating in the tournament
team(oakville).
team(pickering).
team(richmond_hill).
team(scarborough).
team(toronto).

% Define possible results for a match
result(w).  % win
result(l).  % loss
result(d).  % draw
result(n).  % not playing

solve(Tournament) :-
    % Define the structure of the tournament
    % Each round consists of two matches, each match has two teams and their results
    Tournament = [
        [[Team1A, Result1A, Team1B, Result1B], [Team1C, Result1C, Team1D, Result1D]],
        [[Team2A, Result2A, Team2B, Result2B], [Team2C, Result2C, Team2D, Result2D]],
        [[Team3A, Result3A, Team3B, Result3B], [Team3C, Result3C, Team3D, Result3D]],
        [[Team4A, Result4A, Team4B, Result4B], [Team4C, Result4C, Team4D, Result4D]],
        [[Team5A, Result5A, Team5B, Result5B], [Team5C, Result5C, Team5D, Result5D]]
    ],
    

    % Constraints
    % 1. Pickering lost to Scarborough in the first round
    Team1A = pickering, Result1A = l, Team1B = scarborough, Result1B = w,
    
    % Pickering won over Oakville in the second round
    Team2A = pickering, Result2A = w, Team2B = oakville, Result2B = l,

    % 4. All matches in the fourth and fifth round finished with a draw
    Result4A = d, Result4B = d, Result4C = d, Result4D = d, 
    Result5A = d, Result5B = d, Result5C = d, Result5D = d, 

    % All results are valid
    valid_results(Tournament),

    % 6. None of the matches in the first, second and third rounds finished with a draw
    no_draws_first_three(Tournament),   

    % All teams are valid and no team plays against itself
    valid_teams(Tournament),

    % 2. Toronto did not play in the third round, Toronto had one win and one loss in the previous in first two rounds
    not Team3A = toronto, not Team3B = toronto, not Team3C = toronto, not Team3D = toronto,
    toronto_first_two_rounds(Tournament),

    % 3. Oakville did not participate in the fourth round, Oakville  won twice in the preceding three matches
    not Team4A = oakville, not Team4B = oakville, not Team4C = oakville, not Team4D = oakville,
    oakville_wins_first_three(Tournament, 2),

    % 5. Before the fourth round, Richmond Hill won only once and lost once
    richmond_hill_record(Tournament, 1, 1),
    
    % Ensure each team plays 4 times
    unique_matchups(Tournament).
    
   

% Helper predicates

% all results in the tournament are valid
valid_results([]).
valid_results([Round|Rest]) :-
    valid_results_round(Round),
    valid_results(Rest).

% Check if results in a round are valid
valid_results_round([[_, Result1, _, Result2], [_, Result3, _, Result4]]) :-
    result(Result1), result(Result2), result(Result3), result(Result4),
    opposite_results(Result1, Result2),
    opposite_results(Result3, Result4).

% Define opposite results (win-loss, draw-draw, not playing-not playing)
opposite_results(w, l).
opposite_results(l, w).
opposite_results(d, d).

% No draws in the first three rounds
no_draws_first_three([Round1, Round2, Round3|_]) :-
    no_draws_in_round(Round1),
    no_draws_in_round(Round2),
    no_draws_in_round(Round3).

no_draws_in_round([[_, Result1, _, Result2], [_, Result3, _, Result4]]) :-
    not Result1 = d, not Result2 = d, not Result3 = d, not Result4 = d.

% All teams in the tournament are valid
valid_teams([]).
valid_teams([Round|Rest]) :-
    valid_teams_round(Round),
    valid_teams(Rest).

% Check if teams in a round are valid and not playing against themselves
valid_teams_round([[Team1, _, Team2, _], [Team3, _, Team4, _]]) :-
    team(Team1), team(Team2), team(Team3), team(Team4),
    not Team1 = Team2, not Team1 = Team3, not Team1 = Team4,
    not Team2 = Team3, not Team2 = Team4,
    not Team3 = Team4.

% Check Toronto's results in the first two rounds
toronto_first_two_rounds([Round1, Round2|_]) :-
    toronto_in_round(Round1, Result1),
    toronto_in_round(Round2, Result2),
    (Result1 = w, Result2 = l).

toronto_first_two_rounds([Round1, Round2|_]) :-
    toronto_in_round(Round1, Result1),
    toronto_in_round(Round2, Result2),
    (Result1 = l, Result2 = w).

% Find Toronto's result in a given round
toronto_in_round([[toronto, Result, _, _], _], Result).
toronto_in_round([[_, _, toronto, Result], _], Result).
toronto_in_round([_, [toronto, Result, _, _]], Result).
toronto_in_round([_, [_, _, toronto, Result]], Result).

% Check Oakville's wins in the first three rounds
oakville_wins_first_three([Round1, Round2, Round3|_], 2) :-
    oakville_wins_in_round(Round1, Win1),
    oakville_wins_in_round(Round2, Win2),
    oakville_wins_in_round(Round3, Win3),
    Win1 + Win2 + Win3 =:= 2.

% Check if Oakville won in a given round
oakville_wins_in_round([[oakville, w, _, _], _], 1).
oakville_wins_in_round([[_, _, oakville, w], _], 1).
oakville_wins_in_round([_, [oakville, w, _, _]], 1).
oakville_wins_in_round([_, [_, _, oakville, w]], 1).
oakville_wins_in_round(_, 0).

% All teams plays once with each other
unique_matchups(Tournament) :-
    empty_matchup_list(EmptyList),
    process_tournament(Tournament, EmptyList, FinalList),
    all_teams_matched(FinalList).

% Initialize an empty matchup list
empty_matchup_list([
    [oakville, pickering, no],
    [oakville, richmond_hill, no],
    [oakville, scarborough, no],
    [oakville, toronto, no],
    [pickering, richmond_hill, no],
    [pickering, scarborough, no],
    [pickering, toronto, no],
    [richmond_hill, scarborough, no],
    [richmond_hill, toronto, no],
    [scarborough, toronto, no]
]).

% Process the tournament to check for unique matchups
process_tournament([], MatchList, MatchList).
process_tournament([Round|Rest], CurrentList, FinalList) :-
    process_round(Round, CurrentList, NextList),
    process_tournament(Rest, NextList, FinalList).

% Process a round to update matchups
process_round([], MatchList, MatchList).
process_round([[Team1, _, Team2, _]|Rest], CurrentList, FinalList) :-
    update_matchup(Team1, Team2, CurrentList, NextList),
    process_round(Rest, NextList, FinalList).

% Update the matchup list
update_matchup(Team1, Team2, [[Team1, Team2, _]|Rest], [[Team1, Team2, yes]|Rest]).
update_matchup(Team1, Team2, [[Team2, Team1, _]|Rest], [[Team2, Team1, yes]|Rest]).
update_matchup(Team1, Team2, [Match|Rest], [Match|UpdatedRest]) :-
update_matchup(Team1, Team2, Rest, UpdatedRest).

% Check if all teams have been matched
all_teams_matched([]).
all_teams_matched([[_, _, yes]|Rest]) :- all_teams_matched(Rest).
nth1(1, [H|_], H).
    nth1(N, [_|T], X) :- N > 1, N1 is N - 1, nth1(N1, T, X).


% Check Richmond Hill's record before the fourth round
richmond_hill_record(Tournament, Wins, Losses) :-
    richmond_hill_record_helper(Tournament, 0, 0, Wins, Losses, 3).

% Base case: when we've checked all rounds we care about
richmond_hill_record_helper(_, Wins, Losses, Wins, Losses, 0).

% Recursive case: Richmond Hill won this round
richmond_hill_record_helper([Round|Rest], CurrentWins, CurrentLosses, Wins, Losses, RoundsLeft) :-
    richmond_hill_result_in_round(Round, w),
    NextWins is CurrentWins + 1,
    NextRoundsLeft is RoundsLeft - 1,
    richmond_hill_record_helper(Rest, NextWins, CurrentLosses, Wins, Losses, NextRoundsLeft).

% Recursive case: Richmond Hill lost this round
richmond_hill_record_helper([Round|Rest], CurrentWins, CurrentLosses, Wins, Losses, RoundsLeft) :-
    richmond_hill_result_in_round(Round, l),
    NextLosses is CurrentLosses + 1,
    NextRoundsLeft is RoundsLeft - 1,
    richmond_hill_record_helper(Rest, CurrentWins, NextLosses, Wins, Losses, NextRoundsLeft).

% Recursive case: Richmond Hill drew this round
richmond_hill_record_helper([Round|Rest], CurrentWins, CurrentLosses, Wins, Losses, RoundsLeft) :-
    richmond_hill_result_in_round(Round, d),
    NextRoundsLeft is RoundsLeft - 1,
    richmond_hill_record_helper(Rest, CurrentWins, CurrentLosses, Wins, Losses, NextRoundsLeft).

% Recursive case: Richmond Hill didn't play this round
richmond_hill_record_helper([Round|Rest], CurrentWins, CurrentLosses, Wins, Losses, RoundsLeft) :-
    richmond_hill_result_in_round(Round, n),
    NextRoundsLeft is RoundsLeft - 1,
    richmond_hill_record_helper(Rest, CurrentWins, CurrentLosses, Wins, Losses, NextRoundsLeft).

% Find Richmond Hill's result in a given round
richmond_hill_result_in_round([[richmond_hill, Result, _, _], _], Result).
richmond_hill_result_in_round([[_, _, richmond_hill, Result], _], Result).
richmond_hill_result_in_round([_, [richmond_hill, Result, _, _]], Result).
richmond_hill_result_in_round([_, [_, _, richmond_hill, Result]], Result).
richmond_hill_result_in_round(_, n).

time_solve :-
    write('Starting solve predicate...'), nl,
    statistics(runtime, [Start|_]),
    solve(Solution),
    statistics(runtime, [End|_]),
    ExecutionTime is (End - Start) / 1000,  % Convert to seconds
    write('Solve predicate completed in '),
    write(ExecutionTime),
    write(' seconds.'), nl,
    write('Solution found:'), nl,
    print_tournament(Solution).

% Pretty print solution
solve_and_print :-
    solve(Tournament),
    print_tournament(Tournament).

print_tournament([]).
print_tournament([Round|Rest]) :-
    write('Round: '), write(Round), nl,
    print_tournament(Rest).

