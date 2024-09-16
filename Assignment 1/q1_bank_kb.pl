
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

month(1). month(2). month(3). month(4). month(5). month(6).
month(7). month(8). month(9). month(10). month(11). month(12).

%%%%% SECTION: q1_kb
%%%%% You should put the atomic statements in your KB below in this section

% People and their cities
lives(ada_lovelace, san_francisco).   
lives(alan_turing, new_york).  
lives(kirk_douglas, toronto).
lives(harvey_specter, montreal).
lives(bet_cakmak, toronto).      
lives(brad_pitt, vancouver).
lives(rue_scott, calgary).
lives(julia_white, calgary).
lives(max_black, toronto).
lives(stanley_kubrick, vancouver).
lives(jane_eyre, ottawa).
lives(diana_lewis, montreal).
lives(sheldon_cooper, quebec).
lives(heidi_run, toronto).
lives(anne_dray, toronto).


% people and their bank info + balance
hasAccount(ada_lovelace, wells_fargo, 19000). 

hasAccount(alan_turing, rbc, 13200).     
hasAccount(alan_turing, cibc, 18200). 
hasAccount(alan_turing, wells_fargo, 8800). 

hasAccount(kirk_douglas, scotiabank, 11000).
hasAccount(kirk_douglas, bmo, 9500). 
hasAccount(kirk_douglas, cibc, 18800). 

hasAccount(harvey_specter, scotiabank, 20000).
hasAccount(harvey_specter, bmo, 18000).

hasAccount(bet_cakmak, cibc, 6800).

hasAccount(brad_pitt, td, 8500).
hasAccount(brad_pitt, cibc, 42).

hasAccount(rue_scott, rbc, 6100).

hasAccount(julia_white, bmo, 7200). 
hasAccount(julia_white, cibc, 72005). 

hasAccount(max_black, cibc, 4500).
hasAccount(max_black, national_bank, 5600).

hasAccount(stanley_kubrick, rbc, 9200).
hasAccount(stanley_kubrick, cibc, 1540).
hasAccount(stanley_kubrick, national_bank, 16790).

hasAccount(jane_eyre, rbc, 10200).
hasAccount(jane_eyre, national_bank, 12780).

hasAccount(diana_lewis, cibc, 7500).
hasAccount(diana_lewis, national_bank, 8400).

hasAccount(sheldon_cooper, rbc, 12500).
hasAccount(sheldon_cooper, td, 12900).
hasAccount(sheldon_cooper, national_bank, 352355).

hasAccount(heidi_run, cibc, 3498983489).

hasAccount(anne_dray, td, 5000).
hasAccount(anne_dray, rbc, 5400).
hasAccount(anne_dray, cibc, 751651).

% Account creation dates:

created(ada_lovelace, wells_fargo, 5, 2006).  

created(alan_turing, rbc, 1, 2024).   
created(alan_turing, cibc, 1, 2022).              
created(alan_turing, wells_fargo, 4, 2003).   

created(kirk_douglas, scotiabank, 4, 2000).   
created(kirk_douglas, bmo, 9, 2001).      
created(kirk_douglas, cibc, 9, 2019). 

created(harvey_specter, scotiabank, 12, 2002).  
created(harvey_specter, bmo, 6, 2001).

created(rue_scott, rbc, 1, 2024).    

created(julia_white, bmo, 7, 2011).   
created(julia_white, cibc, 7, 2011).             

created(bet_cakmak, cibc, 4, 2018).

created(brad_pitt, cibc, 4, 2018).
created(brad_pitt, td, 3, 1990).   

created(max_black, cibc, 8, 2012).  
created(max_black, national_bank, 4, 2017).   

created(stanley_kubrick, rbc, 6, 2005).   
created(stanley_kubrick, cibc, 11, 2010).
created(stanley_kubrick, national_bank, 6, 2017).   

created(jane_eyre, rbc, 7, 2008).
created(jane_eyre, national_bank, 2, 2017).  

created(diana_lewis, cibc, 1, 2010).
created(diana_lewis, national_bank, 3, 2017).  

created(sheldon_cooper, rbc, 10, 2010).         
created(sheldon_cooper, td, 3, 2015).
created(sheldon_cooper, national_bank, 5, 2017).    

created(heidi_run, cibc, 4, 2009).

created(anne_dray, td, 2, 2015).
created(anne_dray, rbc, 5, 2017).
created(anne_dray, cibc, 9, 2014).
created(anne_dray, national_bank, 8, 2016).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW

