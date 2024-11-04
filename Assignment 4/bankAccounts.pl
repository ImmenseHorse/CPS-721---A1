
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


%%%%% SECTION: database
%%%%% Put statements for account, created, lives, location and gender below

account(12,ann,metro_credit_union,4505).
account(13,robert,rbc,750).
account(14, philip, cibc, 4050).
account(18, philip, cibc, 1029).
account(15, marry, bank_of_montreal, 10900).
account(16, linda, bank_of_america, 400).
account(17, john, rbc, 2500).
account(19, george, scotiabank, 3238).
account(20, hector, hsbc, 329944).
account(21, emma, citibank, 8900).
account(22, mia, western_bank, 12342).
account(23, james, wellsFargo, 31313).
account(24, tom, bank_of_montreal, 100).
account(25, connor, rbc, 100).

created(12, ann, metro_credit_union, 3, 2020).
created(13, robert, rbc, 7, 1996).
created(14, philip, cibc, 5, 2015).
created(18, philip, cibc, 2, 2001).
created(15, marry, bank_of_montreal, 8, 2006).
created(16, linda, bank_of_america, 4, 1993).
created(17, john, rbc, 1, 2023).
created(19, george, scotiabank, 6, 1990).
created(20, hector, hsbc, 9, 2004).
created(21,emma, citibank, 10, 2002).
created(22, mia, western_bank, 12, 2024).
created(23, james, wellsFargo, 11, 1999).
created(24, tom, bank_of_montreal, 3, 1997).
created(25, connor, rbc, 4, 2024).

lives(ann, markham).
lives(robert, losAngeles).
lives(philip, richmondHill).
lives(marry, montreal).
lives(linda, sanFrancisco).
lives(john, richmondHill).
lives(george, northYork).
lives(hector, edmonton).
lives(emma, texas).
lives(mia, vancouver).
lives(james, chicago).
lives(tom, scarborough).
lives(connor, london).

location(scarborough, canada). 
location(markham, canada).
location(richmondHill, canada).
location(montreal, canada).
location(sanFrancisco,usa).
location(northYork, canada).
location(edmonton, canada).
location(texas, usa).
location(vancouver, canada).
location(chicago, usa).
location(london, united_kingdom).
location(toronto, canada).
location(losAngeles, usa).

location(rbc,toronto).
location(metro_credit_union, scarborough).
location(cibc, markham).
location(bank_of_montreal, montreal).
location(bank_of_america, sanFrancisco).
location(scotiabank, edmonton).
location(hsbc, northYork).
location(citibank, texas).
location(western_bank, vancouver).
location(wellsFargo, chicago).

gender(ann, woman).
gender(robert, man).
gender(philip, man).
gender(marry, woman).
gender(linda, woman).
gender(john, man).
gender(george, man).
gender(hector, man).
gender(emma, woman).
gender(mia, woman).
gender(james, man).
gender(tom, man).
gender(connor, man).

%%%%% SECTION: lexicon
%%%%% Put the rules/statements defining articles, adjectives, proper nouns, common nouns,
%%%%% and prepositions in this section.
%%%%% You should also put your lexicon helpers in this section
%%%%% Your helpers should include at least the following:
%%%%%       bank(X), person(X), man(X), woman(X), city(X), country(X)
%%%%% You may introduce others as you see fit
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section


%%%%% helpers
bank(X) :- account(_, _, X, _).
person(X) :- lives(X, _).
man(X) :- gender(X, man).
woman(X) :- gender(X, woman).
city(X) :- lives(_, X).
country(X) :- location(_, X), not city(X).


%%%%% article
article(a).
article(an).
article(the).
article(any).


%%%%% common noun
common_noun(bank, X) :- bank(X).
common_noun(city, X) :- city(X).
common_noun(country, X) :- country(X).
common_noun(man, X) :- man(X).
common_noun(woman, X) :- woman(X).
common_noun(owner, X) :- created(_, X, _, _, _).
common_noun(person, X) :- person(X).
common_noun(account, X) :- account(X, _, _, _).
common_noun(balance, X) :- account(_, _, _, X).

common_noun(american, X) :- adjective(american, X), person(X).
common_noun(canadian, X) :- adjective(canadian, X), person(X).
common_noun(british, X) :- adjective(british, X), person(X).


%%%%% proper noun
proper_noun(X) :- person(X).
proper_noun(X) :- bank(X).
proper_noun(X) :- account(X,_,_,_).
proper_noun(X) :- country(X).
proper_noun(X) :- city(X).
proper_noun(X) :- number(X).


%%%%% adjectives
adjective(canadian, City) :- location(City, canada).
adjective(american, City) :- location(City, usa).
adjective(british, City) :- location(City, united_kingdom).

adjective(canadian, Bank) :- location(Bank, City), location(City, canada).
adjective(american, Bank) :- location(Bank, City), location(City, usa).
adjective(british, Bank) :-  location(Bank, City), location(City, united_kingdom).

adjective(canadian, Person) :-  lives(Person, City), location(City, canada). 
adjective(american, Person) :-  lives(Person, City), location(City, usa). 
adjective(british, Person) :-  lives(Person, City), location(City, united_kingdom).

adjective(canadian, Account) :- account(Account, _, Bank, _), adjective(canadian, Bank).
adjective(american, Account) :- account(Account, _, Bank, _), adjective(american, Bank).
adjective(british, Account) :- account(Account, _, Bank, _), adjective(british, Bank).

adjective(local, X) :- adjective(canadian, X).
adjective(foreign, X) :- adjective(american, X).
adjective(foreign, X) :- adjective(british, X).

adjective(female, X) :- woman(X).
adjective(male, X) :- man(X).

adjective(small, A) :- account(A, _, _, Balance), Balance < 1000.
adjective(large, A) :- account(A, _, _, Balance), Balance > 10000.
adjective(medium, A) :- account(A, _, _, Balance), Balance >= 1000, Balance =< 10000.

adjective(small, B) :- number(B), B < 1000.
adjective(large, B) :- number(B), B > 10000.
adjective(medium, B) :- number(B), B >= 1000, B =< 10000.

adjective(new, A) :- created(A, _, _, _, 2024).
adjective(recent, A) :- adjective(new, A).
adjective(old, A) :- created(A, _, _, _, Y), Y < 2024.


%%%%% Prepositions
preposition(of, X, Y) :- account(X, Y, _, _). 	% X is account of owner Y
preposition(of, X, Y) :- account(Y, X, _, _).	% Y is account of owner X
preposition(of, X, Y) :- account(_, Y, _, X).   % X is balance of owner Y
preposition(of, X, Y) :- account(Y, _, _, X).   % X is balance of account Y

preposition(from, X, Y) :- lives(X, Y).       	% X is person from city Y
preposition(from, X, Y) :- lives(X, City), location(City, Y).	% X is person from country Y

preposition(in, X, Y) :- account(X, _, Y, _).   % X is account in bank Y
preposition(in, X, Y) :- location(X, Y).       	% X is city/bank in country/city Y
preposition(in, X, Y) :- location(X, City), location(City, Y).	% X is bank in country Y

preposition(with, Bank, Account) :- account(Account, _, Bank, _).
preposition(with, Person, Account) :- account(Account, Person, _, _).	% Person with Account (direct relationship)

% Account1 with Account2 (same bank)
preposition(with, Account1, Account2) :- account(Account1, _, Bank, _), account(Account2, _, Bank, _), not Account1 = Account2.

preposition(with, Person, Account) :-	  % More than 1 account at the same bank
    account(Account, Person, Bank, _),    % Person has Account
    account(Account2, Person, Bank, _),   % Person also has Account2 at the same bank
    not Account1 = Account2.


%%%%% SECTION: parser 10 10 10 10 / 11 11 11 11
%%%%% For testing your lexicon for question 3, we will use the default parser initially given to you.
%%%%% ALL QUERIES IN QUESTION 3 and 4 SHOULD WORK WHEN USING THE DEFAULT PARSER
%%%%% For testing your answers for question 5, we will use your parser below
%%%%% You may include helper predicates for Question 5 here, but they
%%%%% should not be needed for Question 3
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj|Rest],What) :- adjective(Adj,What), np2(Rest, What).
np2([Noun|Rest], What) :- common_noun(Noun, What), mods(Rest,What).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, What) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, What),	mods(End, What).

prepPhrase([Prep | Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H | L1], L2, [H | L3]) :-  appendLists(L1, L2, L3).

