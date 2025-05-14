/* Prolog Family Tree - ~20 people with rules and queries */

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

father(X, Y) :- male(X), parent(X, Y).
mother(X, Y) :- female(X), parent(X, Y).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
cousin(X, Y) :- parent(A, X), parent(B, Y), sibling(A, B), X \= Y.
uncle(X, Y) :- male(X), sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).

% ----- Test Queries with Output -----

show_father(X) :-
    father(X, Y),
    format("~w is the father of ~w~n", [X, Y]).

show_mother(X) :-
    mother(X, Y),
    format("~w is the mother of ~w~n", [X, Y]).

show_grandparent(X) :-
    grandparent(X, Y),
    format("~w is the grandparent of ~w~n", [X, Y]).

show_sibling(X) :-
    sibling(X, Y),
    format("~w and ~w are siblings~n", [X, Y]).

show_cousins(X) :-
    cousin(X, Y),
    format("~w and ~w are cousins~n", [X, Y]).

show_uncle(X) :-
    uncle(X, Y),
    format("~w is the uncle of ~w~n", [X, Y]).

show_aunt(X) :-
    aunt(X, Y),
    format("~w is the aunt of ~w~n", [X, Y]).
    
:- initialization(run).

run :-
    show_father(john),
    show_mother(mary),
    show_grandparent(john),
    show_sibling(paul),
    show_cousins(chris),
    show_uncle(michael),
    show_aunt(linda).
