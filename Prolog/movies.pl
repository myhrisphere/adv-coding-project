/* Prolog Movie Recommendation System */

% movie(Title, Genre, Rating (1–5), Year, Director)
movie('Inception', sci_fi, 5, 2010, 'Christopher Nolan').
movie('Interstellar', sci_fi, 5, 2014, 'Christopher Nolan').
movie('The Dark Knight', action, 5, 2008, 'Christopher Nolan').
movie('Fight Club', drama, 5, 1999, 'David Fincher').
movie('Pulp Fiction', crime, 5, 1994, 'Quentin Tarantino').
movie('Forrest Gump', drama, 5, 1994, 'Robert Zemeckis').
movie('Avengers', action, 4, 2012, 'Joss Whedon').
movie('The Godfather', drama, 5, 1972, 'Francis Ford Coppola').
movie('Airplane!', comedy, 4, 1980, 'Jim Abrahams').
movie('Hereditary', horror, 4, 2018, 'Ari Aster').
movie('Get Out', horror, 5, 2017, 'Jordan Peele').
movie('Memento', thriller, 4, 2000, 'Christopher Nolan').
movie('The Matrix', sci_fi, 5, 1999, 'The Wachowskis').
movie('Gladiator', drama, 4, 2000, 'Ridley Scott').
movie('Joker', drama, 5, 2019, 'Todd Phillips').
movie('The Prestige', thriller, 5, 2006, 'Christopher Nolan').
movie('La La Land', musical, 4, 2016, 'Damien Chazelle').
movie('The Shining', horror, 5, 1980, 'Stanley Kubrick').
movie('Tenet', sci_fi, 4, 2020, 'Christopher Nolan').
movie('The Irishman', drama, 4, 2019, 'Martin Scorsese').
movie('Deadpool', action, 4, 2016, 'Tim Miller').
movie('Toy Story', animation, 5, 1995, 'John Lasseter').
movie('Up', animation, 5, 2009, 'Pete Docter').
movie('Zootopia', animation, 4, 2016, 'Byron Howard').
movie('Coco', animation, 5, 2017, 'Lee Unkrich').

% ----- Rules -----

% Find movies by genre
movies_by_genre(Genre, List) :-
    findall(Title, movie(Title, Genre, _, _, _), List).

% Find movies with minimum rating
movies_by_rating(MinRating, List) :-
    findall(Title, (movie(Title, _, Rating, _, _), Rating >= MinRating), List).

% Find movies by director
movies_by_director(Director, List) :-
    findall(Title, movie(Title, _, _, _, Director), List).

% Find movies released after a given year
movies_after_year(Year, List) :-
    findall(Title, (movie(Title, _, _, Y, _), Y > Year), List).

% Top-rated movies of a specific genre
top_rated_by_genre(Genre, List) :-
    findall(Title, (movie(Title, Genre, 5, _, _)), List).

% ----- Sample Queries -----
% ?- movies_by_genre(horror, List).
% ?- movies_by_rating(5, List).
% ?- movies_by_director('Christopher Nolan', List).
% ?- movies_after_year(2010, List).
% ?- top_rated_by_genre(animation, List).


:- initialization(run).

run :-
    show_movies_by_genre(horror),
    show_movies_by_rating(5),
    show_movies_by_director('Christopher Nolan'),
    show_movies_after_year(2010),
    show_top_rated_by_genre(animation).
