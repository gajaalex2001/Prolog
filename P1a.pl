% el = integer
% list = l1...ln
% cautaRec(E:el, L:list)
% model de flux(i,i)
% E-elementul pe care il caut in lista
% L-lista in care caut elementul
cautaRec(E,[E|_]):-!.
cautaRec(E,[_|L]):-cautaRec(E,L).

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
%transforma(L:list,R:list,Rez:list)
%model de flux(i,i,o)
%L-lista pe care vreau sa o transform in multime
%R-lista auxiliara, care are structura de multime
%Rez-lista finala, dupa ce am transformat lista initiala in multime
transforma([],R,Rez):-Rez = R.
transforma([H|T],R,Rez):-not(cautaRec(H,R)),!,
    transforma(T,[H|R],Rez).
transforma([_|T],R,Rez):-transforma(T,R,Rez).


%list = l1...ln
%transformaPrinc(L:list, M:list)
%model de flux(i,o)
%L-lista pe care o transform in multime
%M-lista returnata
transformaPrinc(L,M):-transforma(L,[],M1),invers(M1,M).

test1(Rez):-transformaPrinc([1,2,3,1,2,4],Rez).
test2(Rez):-transformaPrinc([],Rez).
test3(Rez):-transformaPrinc([1,1,1,1],Rez).
test4(Rez):-transformaPrinc([1,2,3,1,2,1,1,2,4,5,4],Rez).
