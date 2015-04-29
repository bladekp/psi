%opis grafu
	gallery(swinoujscie, szczecin).
	gallery(szczecin, kolobrzeg).
	gallery(szczecin, poznan).
	gallery(kolobrzeg, lodz).
	gallery(poznan, wroclaw).
	gallery(wroclaw, radom).
	gallery(lodz, sopot).
	gallery(lodz, radom).
	gallery(sopot, slomin).
	gallery(slomin, biala_podlaska).
	gallery(slomin, warszawa).
	gallery(radom, warszawa ).
	gallery(radom, krakow).
	gallery(warszawa, krakow).
	gallery(krakow, rzeszow).
	gallery(rzeszow, lublin).
	gallery(lublin, biala_podlaska).
	gallery(biala_podlaska, wilno).

%graf nieskierowany
	neighborroom(X, Y) :- gallery(X, Y).
	neighborroom(X, Y) :- gallery(Y, X).

%lista wêz³ów zakazanych
	avoid([]).
	go(Here,There) :- route(Here, There,[Here]).

%rekurencyjne poszukiwanie drogi
route(lublin,lublin,VisitedRooms) :-
	member(warszawa,VisitedRooms), write(VisitedRooms), nl.

	route(Room,Way_out,VisitedRooms) :-
	neighborroom(Room,NextRoom),
	avoid(DangerousRooms),
	\+ member(NextRoom,DangerousRooms),
	\+ member(NextRoom,VisitedRooms),
	route(NextRoom,Way_out,[NextRoom|VisitedRooms]).

%sprawdzenie, czy element wystêpuje w liœcie
	member(X,[X|_]).
	member(X,[_|H]) :- member(X,H).