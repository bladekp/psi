:-dynamic komputer/5.

wykPrg:-
   write('1 - biezacy stan bazy danych'), nl,
   write('2 - dopisanie nowego komputera'), nl,
   write('3 - usuniecie komputera'), nl,
   write('4 - obliczenie sredniej ceny'), nl,
   write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
   write('6 - zapisanie bazy w pliku'), nl,
   write('7 - wyszukiwanie komputerow'), nl,
   write('8 - wyszukiwanie po cenie'), nl,
   write('0 - koniec programu'), nl, nl,
   read(I),
   I > 0,
   opcja(I),
   wykPrg.
wykPrg.

opcja(1) :- wyswietl.
opcja(2) :- write('Podaj nazwe:'), read(Nazwa),
            write('Podaj cene:'), read(Cena), 
			write('Podaj rozmiar HDD:'), read(HDD),
			write('Podaj czestotliwosc zegara:'), read(Zegar),
			write('Podaj ilosc RAM:'), read(RAM), nl,
            assert(komputer(Nazwa, HDD, Zegar, RAM, Cena)).
opcja(3) :- write('Podaj nazwe usuwanego komputera:'), read(Nazwa), 
			write('Podaj cene:'), read(Cena),
            retract(komputer(Nazwa, _, _, _, Cena)),! ;
            write('Brak takiego komputera').
opcja(4) :- sredniaCena.
opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
            exists_file(Nazwa), !, consult(Nazwa);
            write('Brak pliku o podanej nazwie'), nl.
opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
            open(Nazwa, write, X), zapis(X), close(X).
opcja(7) :- write('Podaj nazwe:'), read(Nazwa),
			findall(Nazwa, komputer(Nazwa, _, _, _, _), Lista),
			count(Lista, LiczbaZnalezionych),
			write('Znaleziono: '), write(LiczbaZnalezionych), nl,
			write(Lista), nl.
opcja(8) :- write('Podaj cene maksymalna:'), read(Cena),
			findall(X, komputer(_, _, _, _, X), Lista),
			write(Lista), nl.
opcja(_) :- write('Zly numer opcji'), nl.

wyswietl :- write('Elementy bazy:'), nl,
            komputer(Nazwa, HDD, Zegar, RAM, Cena),
            write(Nazwa), write(' '), write(Cena), write(' '),
			write(HDD), write(' '), write(Zegar), write(' '),
			write(RAM), write(' '),
			nl, fail.
wyswietl :- nl.

sredniaCena :- findall(Cena, komputer(_, _, _, _, Cena), Lista),
              suma(Lista, Suma, LiczbaKomputerow),
              SredniaCena is Suma / LiczbaKomputerow,
              write('Srednia cena:'), write(SredniaCena), nl, nl.

zapis(X) :- komputer(Nazwa, HDD, Zegar, RAM, Cena),
            write(X, 'komputer('),
            write(X, Nazwa), write(X, ','),
			write(X, HDD), write(X, ','),			
			write(X, Zegar), write(X, ','),
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
						 
komputer(czarny, 60, 4, 8, 2500).
komputer(czarny, 80, 4, 6, 2300).
komputer(niebieski, 160, 8, 8, 4000).