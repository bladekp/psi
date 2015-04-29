%opis grafu
gallery(1,2).
gallery(1,3).
gallery(1,4).
gallery(1,5).
gallery(2,10).
gallery(2,9).
gallery(3,10).
gallery(4,6).
gallery(5,8).
gallery(6,7).
gallery(7,13).
gallery(7,8).
gallery(8,9).
gallery(9,10).
gallery(9,11).
gallery(11,12).
gallery(12,13).
gallery(12,15).
gallery(13,14).
gallery(14,15).

% graf nieskierowany
neighborroom(X, Y) :- gallery(X, Y). 
neighborroom(X, Y) :- gallery(Y, X).

%lista wêz³ów zakazanych
avoid([2,6,12]).
go(Here,There) :- route(Here, There,[Here]).

%pisz([|]) :- nl.
%pisz([G|Og]) :- pisz([Og]), write(G), nl.

%rekurencyjne poszukiwanie drogi
route(X,X,VisitedRooms) :-
member(8,VisitedRooms), member(X,VisitedRooms), write(VisitedRooms), nl.

route(Room,Way_out,VisitedRooms) :-
neighborroom(Room,NextRoom),
avoid(DangerousRooms),
\+ member(NextRoom,DangerousRooms),
\+ member(NextRoom,VisitedRooms),
route(NextRoom,Way_out,[NextRoom|VisitedRooms]).

%sprawdzenie, czy element wystêpuje w liœcie
member(X,[X|_]).
member(X,[_|H]) :- member(X,H).