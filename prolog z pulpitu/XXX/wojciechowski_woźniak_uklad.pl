brAND(0,0,1).
brAND(1,0,0).
brAND(0,1,0).
brAND(1,1,1).
brOR(0,0,0).
brOR(1,0,1).
brOR(0,1,1).
brOR(1,1,1).
brXOR(0,0,0).
brXOR(1,0,1).
brXOR(0,1,1).
brXOR(1,1,0).

uklad(A,B,C,D,E,F,G,H,I,J,K) :-
	brAND(A,B,G),
	brXOR(C,D,H),
	brOR(E,F,I),
	brAND(H,I,J),
	brOR(G,J,K).