/* a)
 * Sa se determine pozitiile elementului maxim dintr-o lista liniara.
 * De ex:poz([10,14,12,13,14], L) va produce L = [2,5].
 */


%el = integer
%list = l1...ln
%add(X:el, L:list, Rez:list)
%model de flux(i,i,o)
%X-valoarea pe care vrem sa o adaugam la capatul listei
%L-lista unde vrem sa adaugam valoarea
%Rez-lista rezultat
add(X,[],[X]):-!.
add(X,[Y|Tail],[Y|Tail1]):- add(X,Tail,Tail1).


%el = integer
%list = l1...ln
%max(L:list, Maxim:el, Rez:el)
%model de flux(i,i,o)
%L-lista in care vrem sa gasim valoarea maxima
%Maxim-variabila in care retin maximul pe parcurs
%Rez-rezultatul, valoarea maxima din lista
max([], Maxim, Rez):- Rez = Maxim,!.
max([H|T], Maxim, Rez):-H>Maxim,!,
    max(T, H, Rez).
max([_|T], Maxim, Rez):-max(T, Maxim, Rez).


%el = integer
%list = l1...ln
%poz_aux(L:list, Maxim:el, I:el, R:list, Rez:list)
%model de flux(i,i,i,i,o)
%L-lista in care vrem sa determinam pozitiile elementului maxim
%Maxim-valoarea maxima din lista
%I-variabila in care retinem pozitia
%R-lista in care retin pozitiile gasite
%Rez-lista rezultat
poz_aux([], 0, 1, [], []):-!.
poz_aux([], _, _, R, Rez):- Rez = R.
poz_aux([H|T], Maxim, I, R, Rez):-H=:=Maxim,
    add(I, R, R1),
    I1 is I+1,!,
    poz_aux(T, Maxim, I1, R1, Rez).
poz_aux([H|T], Maxim, I, R, Rez):-H\=Maxim,
    I1 is I+1,
    poz_aux(T, Maxim, I1, R, Rez).


%list = l1...ln
%poz(L:list, Rez:list)
%model de flux(i,o)
%L-lista in care determin pozitiile elementului maxim
%Ret-lista returnata
poz([], []):-!.
poz(L, Rez):- max(L, 0, RezMax),
    poz_aux(L, RezMax, 1, [], Rez).




/* b)
 * Se  da  o  lista  eterogena,  formata  din  numere  intregi  si  liste  de  numere intregi.
 * Sa se inlocuiasca fiecare sublista cu pozitiile elementului maxim din sublista respectiva.
 * De ex:[1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7]
 * =>   [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]
 */


%list = l1...ln
%transformare(L:list, R:list, Rez:list)
%model de flux(i,i,o)
%L-lista pe care vrem sa o transformam
%R-lista in care retin transformarile pe parcurs
%Rez-lista returnata
transformare([], [], []):-!.
transformare([], R, Rez):- !,Rez = R.
transformare([H|T], R, Rez):-number(H),!,
    add(H, R, RezAdd),
    transformare(T, RezAdd, Rez).
transformare([H|T], R, Rez):-not(number(H)),
    poz(H, RezPoz),
    add(RezPoz, R, RezAdd),
    transformare(T, RezAdd, Rez).


%list = l1...ln
%transformareMain(L:list, Rez:list)
%model de flux(i,o)
%L-lista pe care vrem sa o transformam
%Rez-lista rezultata
transformareMain(L,Rez):- transformare(L,[],Rez).

test1(R):-transformareMain([],R).
test2(R):-transformareMain([1,2,3],R).
test3(R):-transformareMain([[1,2,4,3]],R).
test4(R):-transformareMain([1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7],R).




