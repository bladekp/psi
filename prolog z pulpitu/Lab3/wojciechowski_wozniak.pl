:-dynamic komputer/5.

wykPrg:-
   write('1 - Stan bazy danych'), nl,
   write('2 - Dodaj komputer'), nl,
   write('3 - Usun komputer'), nl,
   write('4 - Oblicz srednia cene'), nl,
   write('5 - Dodaj do bazy dane z pliku'), nl,
   write('6 - Zapisz baze do pliku'), nl,
   write('7 - Wyszukaj komputerow'), nl,
   write('8 - Wyszukaj po cenie'), nl,
   write('0 - Koniec programu'), nl, nl,
   read(I),
   I > 0,
   opcja(I),
   wykPrg.
wykPrg.

opcja(1) :- wyswietl.
opcja(2) :- write('Podaj nazwe procesora:'), read(Nazwa),
			write('Podaj czestotliwosc zegara:'), read(Zegar),
			write('Podaj rozmiar HDD:'), read(HDD),
			write('Podaj ilosc RAM:'), read(RAM), nl,
            write('Podaj cene:'), read(Cena), 
            assert(komputer(Nazwa, Zegar, HDD, RAM, Cena)).
opcja(3) :- write('Podaj nazwe procesora dla usuwanego komputera:'), read(Nazwa), 
			write('Podaj zegar:'), read(Zegar),
            retract(komputer(Nazwa, Zegar, _, _, _)),! ;
            write('Brak takiego komputera').
opcja(4) :- sredniaCena.
opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
            exists_file(Nazwa), !, consult(Nazwa);
            write('Brak pliku o podanej nazwie'), nl.
opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
            open(Nazwa, write, X), zapis(X), close(X).
opcja(7) :- write('Podaj nazwe procesora:'), read(Nazwa),
			myfindall(Nazwa, _,_,_,_, Lista),
			count(Lista, LiczbaZnalezionych),
			write('Znaleziono: '), 
			write(LiczbaZnalezionych), nl,
			write(Lista), nl.
opcja(8) :- write('Podaj cene maksymalna:'), read(Cena),
			myfindmin(_, _, _, _, Cena, Lista),
			write(Lista), nl.
opcja(_) :- write('Zly numer opcji'), nl.

myfindall(Nazwa, Zegar, HDD, RAM, Cena, Lista) :-
			findall((Nazwa, Zegar, HDD, RAM, Cena), komputer(Nazwa, Zegar, HDD, RAM, Cena), Lista).
	
myfindmin(Nazwa, Zegar, HDD, RAM, Cena, Lista) :-
			findall((Nazwa, Zegar, HDD, RAM, Cena), komputer(Nazwa, Zegar, HDD, RAM, Cena), Lista).				
			
wyswietl :- write('Elementy bazy:'), nl,
            komputer(Nazwa, Zegar, HDD, RAM, Cena),
            write(Nazwa), write(' '), 
			write(Zegar), write(' '),
			write(HDD), write(' '), 
			write(RAM), write(' '),
			write(Cena), write(' '),
			nl, fail.
wyswietl :- nl.

sredniaCena :- findall(Cena, komputer(_, _, _, _, Cena), Lista),
              suma(Lista, Suma, LiczbaKomputerow),
              SredniaCena is Suma / LiczbaKomputerow,
              write('Srednia cena:'), write(SredniaCena), nl, nl.

zapis(X) :- komputer(Nazwa, HDD, Zegar, RAM, Cena),
            write(X, 'komputer('),
            write(X, Nazwa), write(X, ','),
			write(X, Zegar), write(X, ','),
			write(X, HDD), write(X, ','),		
			write(X, RAM), write(X, ','),
			write(X, Cena), 
            write(X, ').'), nl(X), fail.
zapis(_) :- nl.

suma([],0,0).
suma([G|Og], Suma, N) :- suma(Og, S1, N1),
                         Suma is G + S1,
                         N is N1+1.

count([], 0) :- !.
count([X|T], N) :- count(T, N2),
					N is N2+1.
						 
komputer(intel_pentium, 600, 160, 1024, 2500).
komputer(intel_i3, 2300, 750, 8096, 5300).
komputer(amd, 3500, 80, 256, 4000).
komputer(amd, 3800, 180, 512, 4200).