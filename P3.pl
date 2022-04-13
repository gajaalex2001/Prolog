% munte1(L:list, F:integer)
% model de flux: (i,i)
% L - lista pentru care verificam daca are aspect de munte
% F - variabila care indica daca suntem pe partea de crestere sau
% descrestere
munte([],1).
munte([_], 1):-!.
munte([H1,H2|T], 0):-
H1 < H2,!,
munte([H2|T], 0).
munte([H1,H2|T], 0):-
H1 >= H2,
munte([H2|T], 1).
munte([H1,H2|T], 1):-
H1 > H2,
munte([H2|T], 1).


% munteMain(L:list)
% model de flux: (i)
% L - lista pe care o verificam daca are aspect de munte
verificareMunte([H1,H2|T]):-
H1 < H2,!,
munte([H1,H2|T], 0).


% add(E:integer, L:list, Rez:list)
% model de flux: (i,i,o)
% E - Elementul pe care vrem sa-l adaugam la finalul listei L
% L - Lista in care adaugam
% Rez - Lista rezultat
add(X,[],[X]):-!.
add(X,[Y|Tail],[Y|Tail1]):- add(X,Tail,Tail1).


% comb(L:list, K:integer, C:list)
% model de flux: (i,i,o)
% L - Lista pe care aplicam combinarile
% K - Numarul de elemente pe care le luam in considerare in combinare
% C - Combinarea rezultata
comb([H|_],1,[H]).
comb([_|T],K,C):-comb(T,K,C).
comb([H|T],K,[H|C]):- K>1,
    K1 is K-1,
    comb(T,K1,C).


% combinariPrinc(L:list, K:integer, M:list)
% model de flux: (i,i,o)
% L - Lista pe care aplicam combinarile
% K - Numarul de elemente intr-o combinare
% M - Lista combinarilor
combinariPrinc(L,K,M):-
    findall(X,comb(L,K,X),M).


% subsecventeMunte(L:list, R:list, Rez:list)
% model de flux: (i,i,o)
% L - Lista de subsecvente, in care le cautam pe cele cu structura de
% munte
% R - Variabila colectoare in care imi retin subsecventele gasite pe
% parcurs
% Rez - Lista finala a subsecventelor de tip munte
subsecventeMunte([],[],[]).
subsecventeMunte([],R,Rez):-Rez=R,!.
subsecventeMunte([H|T],R,Rez):- verificareMunte(H),
    add(H,R,R1),!,
    subsecventeMunte(T,R1,Rez).
subsecventeMunte([H|T],R,Rez):- not(verificareMunte(H)),
    subsecventeMunte(T,R,Rez).


% subsecventeMunteMain(L:list, Rez:list)
% model de flux: (i,o)
% L - Lista de subsecvente, in care le cautam pe cele cu structura de
% munte
% Rez - Lista finala a subsecventelor de tip munte
subsecventeMunteMain(L,Rez):-subsecventeMunte(L,[],Rez).


% addMain(L1:list, L2:list, R:list, Rez:list)
% model de flux: (i,i,i,o)
% L1 - Prima lista pe care vrem sa o concatenam
% L2 - A doua lista pe care vrem sa o concatenam
% R - Variabila colectoare, in care imi retin concatenarea pe parcurs
% Rez - Rezultatul final, cele doua liste concatenate
addMain([],[],R,Rez):-Rez = R,!.
addMain([H|T],L,R,Rez):- add(H,R,R1),!,
    addMain(T,L,R1,Rez).
addMain([],[H|T],R,Rez):- add(H,R,R1),
    addMain([], T, R1, Rez).


% addSubmultimi(S1:list, S2:list, Rez:list)
% model de flux: (i,i,o)
% S1 - Prima lista pe care vrem sa o concatenam
% S2 - A doua lista pe care vrem sa o concatenam
% Rez - Lista rezultat, concatenarea celor doua liste introduse
addSubmultimi(S1,S2,Rez):-addMain(S1,S2,[],Rez).


% submultimi(L:list, Len:integer, N:integer, R:list, Rez:list)
% model de flux: (i,i,i,i,o)
% L - Lista in care dorim sa aflam submultimile cu structura de munte
% Len - Lungimea listei introduse
% N - Numarul de elemente pe care le luam in considerare in combinari,
% la un moment dat
% R - Variabila colectoare, in care retin submultimile cu structura de
% munte gasite pe parcurs
% Rez - Lista finala, care cuprinde toate submultimile cu structura de
% munte din lista L
submultimi(_,Len,N,R,Rez):- Len<N,
    Rez=R,!.
submultimi(_,Len,Len,R,Rez):-Rez = R,!.
submultimi(L,Len,N,R,Rez):- N=<Len,
    combinariPrinc(L,N,RezC),
    subsecventeMunteMain(RezC,RezM),
    addSubmultimi(RezM,R,R1),
    N1 is N+1,!,
    submultimi(L,Len,N1,R1,Rez).


% submultimiMain(L:list, Rez:list)
% model de flux: (i,o)
% L - Lista in care aflu submultimile cu structura de munte
% Rez - Lista rezultat
submultimiMain(L,Rez):- length(L,Len),
    submultimi(L,Len,3,[],Rez).

test1(Rez):-submultimiMain([1,2,3,4,2],Rez).
test2(Rez):-submultimiMain([],Rez).
test3(Rez):-submultimiMain([5,4,3,2,1],Rez).
test4(Rez):-submultimiMain([1,2],Rez).
test5(Rez):-submultimiMain([1,2,3,2,6],Rez).

suma([], S, S).
suma([H|T], S, Rez):- S1 is S+H,
    suma(T, S1, Rez).

verifSuma([]).
verifSuma(L):- suma(L, 0, Rez), S is Rez mod 2, S \= 0.








