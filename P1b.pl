%List = l1...ln
%concatenareRec(L1:list, L2:list, R:list, Rez:list)
%model de flux(i,i,i,o)
%L1-prima lista
%L2-a doua lista
%R-lista in care se vor concatena cele 2 liste
%Rez-lista returnata
concatenareRec([],[],R,Rez):-Rez = R,!.
concatenareRec([H|T],L2,R,Rez):-concatenareRec(T,L2,[H|R],Rez).
concatenareRec([],[H|T],R,Rez):-concatenareRec([],T,[H|R],Rez).


%list = l1...ln
%invers(L:list,Rez:list)
%model de flux(i,o)
%L-lista pe care o inversez
%Rez-lista finala, dupa inversare
invers(L,Rez):-invers_aux([],L,Rez).


%list = c1...cn
%invers_aux(Col:list, L:list, Rez:list)
%model de flux(i,i,o)
%Col-variabila colectoare, in care imi pastrez lista in timpul
%    inversarii
%L-lista pe care o inversez
%Rez-lista finala, dupa inversare
invers_aux(Col,[],Col):-!.
invers_aux(Col,[H|T],Rez):-
    invers_aux([H|Col],T,Rez).


%list = l1...ln
%el = integer
%descompune(L:list, Nrp:el, Nri:el, Lp:list, Li:list, R:list)
%model de flux(i,i,i,i,i,o)
%L-lista pe care vrem sa o descompunem
%Nrp-numarul de valori pare gasite in lista
%Nri-numarul de falori impare gasite in lista
%Lp-sublista numerelor pare
%Li-sublista numerelor impare
%R-lista finala returnata
descompune([],0,0,[],[],[0,0]):-!.
descompune([],Nrp,Nri,Lp,Li,R):- invers(Lp,LpI), invers(Li,LiI),
    concatenareRec(LpI,LiI,[],Rez),
    Rez1 = [Nrp|Rez],
    Rez2 = [Nri|Rez1],
    R = Rez2.
descompune([H|T],Nrp,Nri,Lp,Li,R):-mod(H,2)=:=0,
    Nrp1 is Nrp+1,!,
    descompune(T,Nrp1,Nri,[H|Lp],Li,R).
descompune([H|T],Nrp,Nri,Lp,Li,R):-mod(H,2)=:=1,
    Nri1 is Nri+1,!,
    descompune(T,Nrp,Nri1,Lp,[H|Li],R).


%list = l1...ln
%descompunePrinc(L:list, M:list)
%model de flux(i,o)
%L-lista pe care vrem sa o descompunem
%M-lista rezultat
descompunePrinc(L,M):-descompune(L,0,0,[],[],Rez), invers(Rez,M).

test1(R):-descompunePrinc([],R).
test2(R):-descompunePrinc([1],R).
test3(R):-descompunePrinc([2],R).
test4(R):-descompunePrinc([1,2,3,4,5,6,7],R).

