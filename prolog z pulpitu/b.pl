fib(0,0).
fib(1,1).
fib(N,Nfib) :-
N>1,
M is N-1,
O is N-2,
fib(M,Mfib),
fib(O,Ofib),
Nfib is Mfib+Ofib.