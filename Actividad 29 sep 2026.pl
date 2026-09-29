% HECHOS DE VUELOS
vuelo(v101, internacional, lunes, 10).
vuelo(v102, nacional, lunes, 14).
vuelo(v103, internacional, martes, 9).
vuelo(v104, nacional, miercoles, 16).
vuelo(v105, internacional, jueves, 11).

% HECHOS DE PILOTOS
piloto(carlos, [boeing, bilingue, radar]).
piloto(maria, [airbus, bilingue, radar]).
piloto(juan, [boeing, radar]).
piloto(ana, [airbus, bilingue]).

% ASIGNACIONES EXISTENTES
asignado(v090, carlos, lunes, 10).
asignado(v091, maria, martes, 9).
asignado(v092, juan, lunes, 14).
asignado(v093, ana, miercoles, 16).

% BUSQUEDA RECURSIVA EN LISTAS
miembro(X, [X|_]).
miembro(X, [_|R]) :- miembro(X, R).

% REGLA DE DISPONIBILIDAD
disponible(Piloto, Dia, Hora) :-
    \+ asignado(_, Piloto, Dia, Hora).

% REQUISITO SEGUN EL TIPO DE VUELO

% If-Then-Else: SI el vuelo es internacional, el piloto debe tener
% la certificacion bilingue; SI es nacional, no se requiere.

requisito_tipo(TipoVuelo, Piloto, Certificaciones) :-
    (
    TipoVuelo = internacional ->
            miembro(bilingue, Certificaciones);
        TipoVuelo = nacional ->
            true
    ).

% REGLA PRINCIPAL
puede_volar(Piloto, ID_Vuelo) :-
    vuelo(ID_Vuelo, Tipo, Dia, Hora),
    piloto(Piloto, Certificaciones),
    disponible(Piloto, Dia, Hora),
    requisito_tipo(Tipo, Piloto, Certificaciones),
    (
        miembro(boeing, Certificaciones);
        miembro(airbus, Certificaciones)
    ).