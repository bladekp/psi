:- dynamic xpositive/2.
:- dynamic xnegative/2.

%1. Opis obiektów (ich cech charakterystycznych)

vehicle_is(kon) :-
it_is(land),
negative(has,engine),
negative(has,wheels),
negative(has,two_wheels),
negative(has,four_wheels),
negative(has,ten_wheels).

vehicle_is(samochod_osobowy) :-
it_is(land),
it_is(motored),
positive(has,four_wheels).

vehicle_is(motor) :-
it_is(land),
it_is(motored), 
positive(has,two_wheels).

vehicle_is(rower) :-
it_is(land) ,
positive(has, two_wheels),
negative(has, engine).

vehicle_is(samochod_ciezarowy) :-
it_is(land) ,
it_is(motored),
positive(has,ten_wheels).

vehicle_is(buldorzer) :-
it_is(land),
it_is(motored),
negative(has,wheels),
negative(has,two_wheels),
negative(has,four_wheels),
negative(has,ten_wheels).

vehicle_is(samolot) :-
it_is(air),
it_is(motored),
positive(has,wings),
negative(has, propeler).

vehicle_is(helikopter) :-
it_is(air),
it_is(motored),
positive(has,propeler),
negative(has,wings).

vehicle_is(zaglowka) :-
it_is(water),
positive(has, sail),
negative(has, guns).

vehicle_is(motorowka) :-
it_is(water),
it_is(motored),
negative(has,guns),
negative(has,sail).

vehicle_is(pancernik) :-
it_is(water),
it_is(motored),
positive(has,guns),
negative(has,sail).

%2. Opis cech charakterystycznych dla klas obiektów
it_is(air) :-
	positive(can,fly).
it_is(water) :-
	positive(can,swim).
it_is(motored) :-
	positive(has,engine).
it_is(land) :-
	negative(can, fly),
	negative(can, swim).

%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
positive(X,Y) :-xpositive(X,Y),!.
positive(X,Y) :-
not(xnegative(X,Y)) , ask(X,Y,yes).
negative(X,Y) :-xnegative(X,Y),!.
negative(X,Y) :-
not(xpositive(X,Y)),
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