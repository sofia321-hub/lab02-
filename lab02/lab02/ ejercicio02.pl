power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).

villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).


%transición de estados
%estado(VillanosRestantes, Poderes, Energia)
siguiente_estado(
    estado([villain(Nombre, Vida, Debilidades)|Resto], Poderes, Energia),
    estado(Resto, Poderes, NuevaEnergia)
) :-
    member(power(Poder, Danio, Costo), Poderes),
    member(Poder, Debilidades),
    Energia >= Costo,
    Danio >= Vida,
    NuevaEnergia is Energia - Costo.


% DFS
dfs(estado([], _, _), _).

dfs(EstadoActual, Visitados) :-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    \+ member(EstadoSiguiente, Visitados),
    dfs(EstadoSiguiente,
        [EstadoSiguiente | Visitados]).


%predicado principal
batman_can_win(EnergiaMaxima) :-
    power_list(Poderes),
    villain_list(Villanos),
    EstadoInicial = estado(Villanos, Poderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]).


%CONSULTA DE PRUEBA
%batman_can_win(60).
%true.
%batman_can_win(30).
%false.
