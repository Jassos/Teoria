% Motor lógico para una plataforma de Trabajo Remoto (estilo Upwork o Workana)
% Criterios de Evaluación: 
% Uso correcto de recursividad en listas
% condicionales (If-Then-Else)
% disyunción (;)
% negación por fallo (\+)
% Uso de variables anónimas.

% 6 Candidatos (Nombre, Nivel, TarifaHora, [Lista_Tecnologias])
candidato(sofia, senior, 45, [python, react, sql]).
candidato(maria, senior, 50, [node, python]).
candidato(pedro, mid_level, 30, [java, c]).
candidato(ana, senior, 25, [python, javascript]).
candidato(luis, senior, 45, [java, node]).
candidato(sara, mid_level, 35, [javascript, c]).

% 3 Proyectos (ID_proyecto, Cliente, Seniority_Requerido.)
proyecto(1, acme_corp, senior).
proyecto(2, lintern_corp, mid_level).
proyecto(3, monster_inc, junior).

% Penalización por incumplimiento de contrato o malas reseñas (nombre)
penalizado(luis).
penalizado(sara).

% Regla 1: Manejo de Listas (Recursividad):
% Recorrer recursivamente el stack para verificar si conoce la herramienta buscada.
domina_tech(Tech, [Tech|_]).
domina_tech(Tech, [_|Resto]) :-
    domina_tech(Tech, Resto).

% Regla 2: Filtro de Presupuesto (If-Then-Else):
% SI el proyecto requiere un nivel Senior, el presupuesto aprueba si la tarifa del candidato es menor o oigual a 50.
% SI NO (proyecto Junior), aprueba solo si la tarifa es menor o igual a 20.
presupuesto_apto(Tarifa, Nivel_Proyecto) :-
    (   Nivel_Proyecto = senior
    ->  Tarifa =< 50
    ;   Tarifa =< 20
    ).

% Regla 3: Evaluación de reputación (Negación por fallo):
% Un cantidadto tiene buen gistorial únicamente si NO eiste un registro de él en los hechos de penalizado/1
historial_limpio(Nombre) :-
    \+ penalizado(Nombre).

% Regla 4: Perfil Versatil (Disyunción OR):
% Un candidato es versatil si su lista contiene React o Node. (Utilizamos la regla 1 para hacer la busqueda.)
perfil_versatil(Lista_Tecnologias) :-
    (   domina_tech(react, Lista_Tecnologias);   
        domina_tech(node, Lista_Tecnologias)
    ).

% Regla 5: Contratación (Generar y Probar):
% Un candidato es apto para un proyecto SI:
% 1. Se extraen los datos del proyecto (Seniority_requerido). Usando una variable anonima para el cliente (No afecta.)
% 2. Se extraen los datos del candidato (Nivel, TarifaHora, Lista_Tecnologias).
% 3. El nivel del candidato es igual al Seniority_requerido.
% 4. El candidato tiene un presupuesto apto para el proyecto
% 5. El candidato tiene buen historial.
% 6. El candidato es versatil
puede_contratar(Nombre, ID_Proyecto) :-
    proyecto(ID_Proyecto, _, Seniority_Requerido),
    candidato(Nombre, Nivel, TarifaHora, Lista_Tecnologias),
    Nivel = Seniority_Requerido,
    presupuesto_apto(TarifaHora, Seniority_Requerido),
    historial_limpio(Nombre),
    perfil_versatil(Lista_Tecnologias).