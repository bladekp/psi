%opis grafu
	gallery(swinoujscie, szczecin, 4).
	gallery(szczecin, kolobrzeg,5).
	gallery(szczecin, poznan, 7).
	gallery(kolobrzeg, lodz,4).
	gallery(poznan, wroclaw,7).
	gallery(wroclaw, radom,9).
	gallery(lodz, sopot,2).
	gallery(lodz, radom,9).
	gallery(sopot, slomin,1).
	gallery(slomin, biala_podlaska,6).
	gallery(slomin, warszawa,9).
	gallery(radom, warszawa ,6).
	gallery(radom, krakow,3).
	gallery(warszawa, krakow,4).
	gallery(krakow, rzeszow,6).
	gallery(rzeszow, lublin,3).
	gallery(lublin, biala_podlaska,1).
	gallery(biala_podlaska, wilno,2).

%funkcja wypisuj¹ca
	pisz([]).
	pisz([G|Og]) :- 
		pisz(Og), 
		write(G), write(' -> ').
	
%graf nieskierowany
	neighborroom(X, Y,Z) :- gallery(X, Y,Z).
	neighborroom(X, Y,Z) :- gallery(Y, X,Z).
	
%lista wêz³ów zakazanych
	avoid([sopot, kolobrzeg]).
	go(Here,There) :- route(Here, There,[Here], Koszt).

%rekurencyjne poszukiwanie drogi
route(There,There,VisitedRooms, Cost) :- pisz(VisitedRooms), nl.

	route(Room,Way_out,VisitedRooms, Cost) :-
	neighborroom(Room,NextRoom),
	avoid(DangerousRooms),
	Droga is Droga + Cost,
	\+ member(NextRoom,DangerousRooms),
	\+ member(NextRoom,VisitedRooms),
	route(NextRoom,Way_out,[NextRoom|VisitedRooms], Droga).

%sprawdzenie, czy element wystêpuje w liœcie
	member(X,[X|_]).
	member(X,[_|H]) :- member(X,H).
	
