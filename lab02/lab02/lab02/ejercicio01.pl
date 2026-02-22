
% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).
ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1, 2, 4).
ubicacion(piedra2, 5, 6).
ubicacion(piedra3, 8, 4).
ubicacion(piedra4, 5, 0).
ubicacion(orilla_final, 10, 5).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).

%calculo de distancia euclidiana
distancia(L1, L2, D) :-
    ubicacion(L1, X1, Y1),
    ubicacion(L2, X2, Y2),
    DX is X2 - X1,
    DY is Y2 - Y1,
    D is sqrt(DX*DX + DY*DY).


%transición de estados
siguiente_estado(pos(Actual), pos(Siguiente)) :-
    ubicacion(Siguiente, _, _),
    Actual \= Siguiente,
    distancia(Actual, Siguiente, D),
    salto_maximo(Max),
    D =< Max.

%DFS
dfs(pos(orilla_final), Visitados, Visitados).

dfs(EstadoActual, Visitados, Solucion) :-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    \+ member(EstadoSiguiente, Visitados),
    dfs(EstadoSiguiente,
        [EstadoSiguiente | Visitados],
        Solucion).

buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial),
    dfs(EstadoInicial, [EstadoInicial], Solucion).


%CONSULTA DE PRUEBA
%buscar_solucion(S).
% S = [pos(orilla_final),
%      pos(piedra3),
%      pos(piedra2),
%      pos(piedra1),
%      pos(orilla_inicial)].
