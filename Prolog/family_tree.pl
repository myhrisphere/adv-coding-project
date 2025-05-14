/* Prolog Family Tree - ~20 people with rules */

% ----- Facts -----

% Male members
male(john). male(michael). male(robert). male(paul). male(daniel).
male(alex). male(chris). male(henry). male(james). male(nick).

% Female members
female(mary). female(linda). female(elizabeth). female(susan). female(anna).
female(kate). female(emily). female(sophie). female(lucy). female(julia).

% Parent relationships
parent(john, michael).
parent(mary, michael).
parent(john, linda).
parent(mary, linda).

parent(michael, robert).
parent(susan, robert).
parent(michael, elizabeth).
parent(susan, elizabeth).

parent(linda, paul).
parent(alex, paul).
parent(linda, anna).
parent(alex, anna).

parent(robert, chris).
parent(kate, chris).

parent(elizabeth, emily).
parent(daniel, emily).

parent(paul, henry).
parent(sophie, henry).

parent(anna, lucy).
parent(james, lucy).

parent(emily, julia).
parent(nick, julia).

% ----- Rules -----

% X is the father of Y
father(X, Y) :- male(X), parent(X, Y).

% X is the mother of Y
mother(X, Y) :- female(X), parent(X, Y).

% X is a grandparent of Y
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% X and Y are siblings
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% X is a cousin of Y
cousin(X, Y) :-
    parent(A, X), parent(B, Y),
    sibling(A, B), X \= Y.

% X is an uncle of Y
uncle(X, Y) :-
    male(X), sibling(X, Z), parent(Z, Y).

% X is an aunt of Y
aunt(X, Y) :-
    female(X), sibling(X, Z), parent(Z, Y).

% ----- Sample Queries -----
% ?- father(john, michael).
% ?- mother(linda, paul).
% ?- grandparent(john, robert).
% ?- sibling(paul, anna).
% ?- cousin(chris, emily).
% ?- uncle(michael, elizabeth).
% ?- aunt(linda, anna).