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

%%%%% TEST TREES
% Below you can find two test trees. 
% They have been added using atomic statements of the form testTree(TestNum, Tree).
% You can use them in a query as follows:
%
% ?- testTree(1, T), preorder(T, List).
%
% That will match T to the first test tree, and then run your preorder program on it.
% 
% You may also add additional tree below for testing in this way, though we will not mark them.

% Test Tree 1
% This tree has a root named a, which has 3 leaf children named 1, 2, 3
% The expected answer for preorder on this tree is next(a, next(1, next(2, next(3, nil))))
testTree(1,
    tree3(a,
            tree3(1, none, none, none),
            tree3(2, none, none, none),
            tree3(3, none, none, none)
        )
).

% This is the tree from the assignment description.
% See the expected answer for preorder there
testTree(2, 
    tree3(a,  % The root node has name a
            tree3(b, % Left child of a is b
                    tree3(e, none, none, none),   % Left child of b is e. It is a leaf node
                    tree3(f, none, none, none),   % Middle child of b is f. It is a leaf node
                    none  % There is no right child of b
                    ),
            tree3(c, none, none, none),  % Middle child of a is c. It is a leaf node
            tree3(d,   % Right child of a is d
                    tree3(g, 
                        none, 
                        none,   % Left child of d is g. It has no left or middle child
                        tree3(h, none, none, none)),   % The right child of g is h. It is a leaf node
                    none, 
                    none  % d has no middle or right children
                    )
        )
).

%%%%% SECTION: preorder
%%%%% Put your rules for preorder and any helper predicates below

preorder(none, nil).
preorder(tree3(Name, Left, Middle, Right), List) :-
    preorder_helper(tree3(Name, Left, Middle, Right), List, nil).

% Helper predicate to perform the actual traversal
preorder_helper(none, List, List).
preorder_helper(tree3(Name, Left, Middle, Right), List, Acc) :-
    preorder_helper(Right, RightList, Acc),
    preorder_helper(Middle, MiddleList, RightList),
    preorder_helper(Left, LeftList, MiddleList),
    List = next(Name, LeftList).


