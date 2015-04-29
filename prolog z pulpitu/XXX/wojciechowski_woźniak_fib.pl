fib(N,0):-
	N =:= 0,
	!.
fib(N,1):-
	N>0,
	N<3,
	!.
fib(N, R):-
	fib(N-1, R2),
	fib(N-2, R3),
	R is R2+R3.