% Juegos
videojuego(smash).
videojuego(fifa).
videojuego(mario_kart).

% Generos: Competitivo / Casual
genero(smash, competitivo).
genero(fifa, competitivo).
genero(mario_kart, casual).

% Estudiantes inscritos al torneo
inscrito(carlos).
inscrito(ana).
inscrito(pedro).

% Estudiante / Videojuego
juega(carlos, smash).
juega(ana, mario_kart).
juega(pedro, fifa).
juega(luis, smash).

% Regla 1: Un videojuego puede pasar a la ronda final SI: 
% 1. es competitivo
% 2. Tiene al menos un jugador.
habilitado(Juego) :-
    videojuego(Juego),
    genero(Juego, competitivo),
    once(juega(_, Juego)).

% Regla 2: Dos estudiantes son rivales SI:
% 1. Juegan el mismo videojuego
% 2. Son personas diferentes.
rivales(Estudiante1, Estudiante2) :-
    juega(Estudiante1, Juego),
    juega(Estudiante2, Juego),
    Estudiante1 \= Estudiante2.