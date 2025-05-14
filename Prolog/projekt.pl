% ===================================================
% SECTION 1: FAMILY TREE
% ===================================================

% Male members
male(john). male(michael). male(robert). male(paul). male(daniel).
male(alex). male(chris). male(henry). male(james). male(nick).

% Female members
female(mary). female(linda). female(elizabeth). female(susan). female(anna).
female(kate). female(emily). female(sophie). female(lucy). female(julia).

% Parent relationships
parent(john, michael).  parent(mary, michael).
parent(john, linda).    parent(mary, linda).
parent(michael, robert). parent(susan, robert).
parent(michael, elizabeth). parent(susan, elizabeth).
parent(linda, paul). parent(alex, paul).
parent(linda, anna). parent(alex, anna).
parent(robert, chris). parent(kate, chris).
parent(elizabeth, emily). parent(daniel, emily).
parent(paul, henry). parent(sophie, henry).
parent(anna, lucy). parent(james, lucy).
parent(emily, julia). parent(nick, julia).

/* --- Rules --- */

father(X, Y) :- male(X), parent(X, Y).
mother(X, Y) :- female(X), parent(X, Y).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
cousin(X, Y) :- parent(A, X), parent(B, Y), sibling(A, B), X \= Y.
uncle(X, Y) :- male(X), sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).

/* --- Output Predicates --- */

show_father(X) :- father(X, Y), format("~w is the father of ~w~n", [X, Y]).
show_mother(X) :- mother(X, Y), format("~w is the mother of ~w~n", [X, Y]).
show_grandparent(X) :- grandparent(X, Y), format("~w is the grandparent of ~w~n", [X, Y]).
show_sibling(X) :- sibling(X, Y), format("~w and ~w are siblings~n", [X, Y]).
show_cousins(X) :- cousin(X, Y), format("~w and ~w are cousins~n", [X, Y]).
show_uncle(X) :- uncle(X, Y), format("~w is the uncle of ~w~n", [X, Y]).
show_aunt(X) :- aunt(X, Y), format("~w is the aunt of ~w~n", [X, Y]).


% ===================================================
% SECTION 2: MOVIE DATABASE
% ===================================================

/* --- Movies --- */
movie('Inception', sci_fi, 5, 2010, 'Christopher Nolan', 'A man enters dreams to complete a mission').
movie('Interstellar', sci_fi, 5, 2014, 'Christopher Nolan', 'Astronauts search space to save humanity').
movie('The Dark Knight', action, 5, 2008, 'Christopher Nolan', 'Batman faces the Joker in Gotham').
movie('Fight Club', drama, 5, 1999, 'David Fincher', 'A man starts a fight club to feel alive').
movie('Pulp Fiction', crime, 5, 1994, 'Quentin Tarantino', 'Stories of crime intersect in strange ways').
movie('Forrest Gump', drama, 5, 1994, 'Robert Zemeckis', 'A kind man witnesses major events in history').
movie('Avengers', action, 4, 2012, 'Joss Whedon', 'Superheroes team up to save Earth').
movie('The Godfather', drama, 5, 1972, 'Francis Ford Coppola', 'A mafia family struggles with power and loyalty').
movie('Airplane!', comedy, 4, 1980, 'Jim Abrahams', 'A man must land a plane despite panic and chaos').
movie('Hereditary', horror, 4, 2018, 'Ari Aster', 'A family discovers terrifying secrets').
movie('Get Out', horror, 5, 2017, 'Jordan Peele', 'A man visits his girlfriend’s unsettling family').
movie('Memento', thriller, 4, 2000, 'Christopher Nolan', 'A man with memory loss investigates his wife’s death').
movie('The Matrix', sci_fi, 5, 1999, 'The Wachowskis', 'A hacker learns reality is a simulation').
movie('Gladiator', drama, 4, 2000, 'Ridley Scott', 'A Roman general seeks revenge in the arena').
movie('Joker', drama, 5, 2019, 'Todd Phillips', 'A man’s mental descent turns him into a villain').
movie('The Prestige', thriller, 5, 2006, 'Christopher Nolan', 'Two rival magicians compete dangerously').
movie('La La Land', musical, 4, 2016, 'Damien Chazelle', 'A couple chases dreams and love in Hollywood').
movie('The Shining', horror, 5, 1980, 'Stanley Kubrick', 'A writer loses sanity in a haunted hotel').
movie('Tenet', sci_fi, 4, 2020, 'Christopher Nolan', 'A secret agent manipulates time to stop catastrophe').
movie('The Irishman', drama, 4, 2019, 'Martin Scorsese', 'An old hitman recalls his life in crime').
movie('Deadpool', action, 4, 2016, 'Tim Miller', 'A sarcastic antihero takes revenge').
movie('Toy Story', animation, 5, 1995, 'John Lasseter', 'Toys come to life when humans aren’t looking').
movie('Up', animation, 5, 2009, 'Pete Docter', 'An old man flies away in a balloon house').
movie('Zootopia', animation, 4, 2016, 'Byron Howard', 'A bunny cop solves a mystery in animal city').
movie('Coco', animation, 5, 2017, 'Lee Unkrich', 'A boy travels to the Land of the Dead to find his roots').

/* --- Movie Rules --- */
movies_by_genre(Genre, List) :- findall(Title, movie(Title, Genre, _, _, _, _), List).
movies_by_rating(MinRating, List) :- findall(Title, (movie(Title, _, Rating, _, _, _), Rating >= MinRating), List).
movies_by_director(Director, List) :- findall(Title, movie(Title, _, _, _, Director, _), List).
movies_after_year(Year, List) :- findall(Title, (movie(Title, _, _, Y, _, _), Y > Year), List).
top_rated_by_genre(Genre, List) :- findall(Title, (movie(Title, Genre, 5, _, _, _)), List).

/* --- Output Predicates --- */
show_movies_by_genre(Genre) :-
    movies_by_genre(Genre, List),
    format("Movies in genre ~w: ~w~n", [Genre, List]).

show_movies_by_rating(Rating) :-
    movies_by_rating(Rating, List),
    format("Movies with rating >= ~w: ~w~n", [Rating, List]).

show_movies_by_director(Director) :-
    movies_by_director(Director, List),
    format("Movies directed by ~w: ~w~n", [Director, List]).

show_movies_after_year(Year) :-
    movies_after_year(Year, List),
    format("Movies released after ~w: ~w~n", [Year, List]).

show_top_rated_by_genre(Genre) :-
    top_rated_by_genre(Genre, List),
    format("Top-rated movies in genre ~w: ~w~n", [Genre, List]).

show_movie_descriptions :-
    movie(Title, _, _, _, _, Desc),
    format("~w: ~w~n", [Title, Desc]),
    fail.
show_movie_descriptions.


% ===================================================
% INITIALIZATION
% ===================================================

:- initialization(run).

run :-
    % Family tree queries
    write('=== FAMILY TREE ==='), nl,
    show_father(john),
    show_mother(mary),
    show_grandparent(john),
    show_sibling(paul),
    show_cousins(chris),
    show_uncle(michael),
    show_aunt(linda),

    % Movie database queries
    nl, write('=== MOVIE DATABASE ==='), nl,
    show_movies_by_genre(horror),
    show_movies_by_rating(5),
    show_movies_by_director('Christopher Nolan'),
    show_movies_after_year(2010),
    show_top_rated_by_genre(animation),
    write('--- Movie Descriptions ---'), nl,
    show_movie_descriptions.
