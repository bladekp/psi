:- dynamic xpositive/2.
:- dynamic xnegative/2.

%1. Opis obiektów (ich cech charakterystycznych)
vehicle_is(motor) :-
it_is(land) ,
it_is(motored), 
positive(has,two_wheels).

vehicle_is(rower) :-
it_is(land) ,
positive(has, two_wheels) ,
negative(has, engine).

vehicle_is(osobowy) :-
it_is(land) ,
it_is(motored),
positive(has,four_wheels) ,
positive(has,four_places).

vehicle_is(towarowy) :-
it_is(land) ,
it_is(motored),
positive(has,four_wheels),
negative(has,four_places).

vehicle_is(tir) :-
it_is(land) ,
it_is(motored),
positive(has,ten_wheels) .

vehicle_is(czo³g) :-
it_is(land),
it_is(motored),
negative(has,four_wheels),
negative(has,two_wheels),
negative(has,ten_wheels).

vehicle_is(samolot) :-
it_is(air) ,
it_is(motored),
positive(has,wings).

vehicle_is(helikopter) :-
it_is(air),
it_is(motored),
negative(has,wings).

vehicle_is(statek) :-
it_is(water),
it_is(motored).

vehicle_is(kajak) :-
it_is(water),
negative(has,engine).

%2. Opis cech charakterystycznych dla klas obiektów
it_is(land) :-
negative(can, fly),
negative(can, swim).
it_is(air) :-
positive(can,fly).
it_is(water) :-
positive(can,swim).
it_is(motored) :-
positive(has,engine).

%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
positive(X,Y) :-xpositive(X,Y),!.
positive(X,Y) :-
not(xnegative(X,Y)) , ask(X,Y,yes).
negative(X,Y) :-xnegative(X,Y),!.
negative(X,Y) :-
not(xpositive(X,Y)) ,
ask(X,Y,no).

%4. Zadawanie pytañ uSytkownikowi
ask(X,Y,yes) :-
write(X), write(' it '),write(Y), write('\n'),
read(Reply),
sub_string(Reply,0,1,_,'y'),!,
remember(X,Y,yes).

ask(X,Y,no) :-
write(X), write(' it '),write(Y), write('\n'),
read(Reply),
sub_string(Reply,0,1,_,'n'),!,
remember(X,Y,no). 


%5. Zapamiêtanie odpowiedzi w dynamicznej bazie
remember(X,Y,yes) :-
asserta(xpositive(X,Y)).
remember(X,Y,no) :-
asserta(xnegative(X,Y)).

%6. Uruchomienie programu
run :-
vehicle_is(X),!,
write('\nTwoj pojazd to: '),write(X),
nl,nl,clear_facts.
run :-
write('\nNie udalo sie dopasowac '),
write('pojazdu.\n\n'),clear_facts.

%7. Wyczyszczenie zawartoœci dynamicznej bazy
clear_facts :-
retract(xpositive(_,_)),fail.
clear_facts :-
retract(xnegative(_,_)),fail.
clear_facts :-
write('\n\nPlease press the space bar to exit\n').