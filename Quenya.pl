% Movimiento (nodo actual, nodo destino, letra)
grafo(a, b, a).
grafo(b, c, n).
grafo(b, d, m).
grafo(c, e, a).
grafo(c, f, c).
grafo(c, g, d).
grafo(d, h, i).
grafo(e, i, r).
grafo(f, j, a).
grafo(h, k, l).
grafo(i, l, y).
grafo(l, z, a).
 
% Estados de aceptacion, nodo destino 
final(c).
final(g).
final(j).
final(k).
final(z).
 
verificar(Palabra) :-
    validar(Palabra, a).
 
validar([], Estado) :-
    final(Estado).
 
validar([Letra | Resto], Estado) :-
    grafo(Estado, Siguiente, Letra),
    validar(Resto, Siguiente).
 
amil:-
    write('amil'), nl,
    write('Resultado: true'), nl,
    verificar([a, m, i, l]).
 
an:-
    write('an'), nl,
    write('Resultado: true'), nl,
    verificar([a, n]).
 
anarya:-
    write('anarya'), nl,
    write('Resultado: true'), nl,
    verificar([a, n, a, r, y, a]).
 
anca:-
    write('anca'), nl,
    write('Resultado: true'), nl,
    verificar([a, n, c, a]).
 
and:-
    write('and'), nl,
    write('Resultado: true'), nl,
    verificar([a, n, d]).
