
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

%%%%% SECTION: q2_kb
%%%%% You should put the atomic statements in your KB below in this section

hasAccount(john, cibc, 1000).
hasAccount(john, bmo, 500).

hasAccount(amy, cibc, 1000).
hasAccount(amy, bmo, 600).

totalDeposits(john, cibc, 500).
totalDeposits(john, bmo, 500).

totalDeposits(amy, cibc, 600).
totalDeposits(amy, bmo, 600).

totalWithdrawals(john, cibc, 400).
totalWithdrawals(john, bmo, 400).

totalWithdrawals(amy, cibc, 300).
totalWithdrawals(amy, bmo, 300).

monthlyRate(cibc, 0.005).
monthlyRate(bmo, 0.004).

interestLevel(cibc, 1000).
interestLevel(bmo, 1500).

penalty(cibc, 30).
penalty(bmo, 50).

%%%%% SECTION: q2_rules
%%%%% Put statements for subtotal, accruedInterest, accruedPenalty, and endOfMonthBalance below.
%%%%% You may also put helper predicates here
%%%%% DO NOT PUT ATOMIC FACTS FOR hasAccount, totalDeposits, totalWithdrawals, monthlyRate, interestRate, or penalty below.

subtotal(Name, Bank, Subtotal) :- hasAccount(Name, Bank, X), totalDeposits(Name, Bank, Y), totalWithdrawals(Name, Bank, Z), Subtotal is X + Y - Z.

accruedInterest(Name, Bank, I) :- interestLevel(Bank, X), subtotal(Name, Bank, Subtotal), Subtotal >= X, monthlyRate(Bank, Y), I is Subtotal * Y.

accruedInterest(Name, Bank, I) :- interestLevel(Bank, X), subtotal(Name, Bank, Subtotal), Subtotal < X, I is 0.

accruedPenalty(Name, Bank, P) :- subtotal(Name, Bank, Subtotal), Subtotal >= 0, P is 0.

accruedPenalty(Name, Bank, P) :- subtotal(Name, Bank, Subtotal), Subtotal < 0, penalty(Bank, X), P is X.

endOfMonthBalance(Name, Bank, Balance) :- subtotal(Name, Bank, Subtotal), accruedInterest(Name, Bank, I), accruedPenalty(Name, Bank, P), Balance is Subtotal + I - P.

endOfMonthBalance(Name, Balance) :- endOfMonthBalance(Name, cibc, X), endOfMonthBalance(Name, bmo, Y), Balance is X + Y.


%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW
