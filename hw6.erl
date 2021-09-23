% Danielle Levy

-module(hw6).
-export([rec_fn/1, zip/2, foldl/3, scalar_product/2, mat_mul/2, scalar_product_sp/0]).

% 1 rec_fn/1
rec_fn(1) -> 1;
rec_fn(2) -> 1;
rec_fn(N) -> rec_acc(N - 1, 1, 1).
%rec_fn(N) -> 2 * rec_fn(N - 1) -3 * rec_fn(N - 2).

rec_acc(0, A, _) -> A;
rec_acc(N, A, B) -> rec_acc((N - 1), B, (2*B - 3*A)).

% 2 zip/2
zip([],[]) -> [];
zip(_,[]) -> [];
zip([],_) -> [];
zip([Hd1 | Tl1], [Hd2 | Tl2]) -> [{Hd1, Hd2} | zip(Tl1, Tl2)].

% 3 foldl/3
foldl(_, Z, []) -> Z;
foldl(Func, Z, [Hd | Tl]) -> foldl(Func, Func(Z, Hd), Tl).

% 4 scalar_product/2
scalar_product([],[]) -> 0;
scalar_product(L1, L2) -> foldl_sum(lists:map(fun({X,Y}) -> X*Y end, zip(L1, L2))).

foldl_sum([]) -> 0;
foldl_sum(L) -> foldl(fun(X, Sum) -> X + Sum end, 0, L).

% 5 mat_mul/2
mat_mul([[A11, A12], [A21, A22]], [[B11, B12], [B21, B22]]) ->
Pid = spawn(hw6, scalar_product_sp, []),
Pid ! {self(), [A11, A12], [B11, B21]},
receive
	{AB11} -> Pid ! {self(), [A11, A12], [B12, B22]}
end,
receive
	{AB12} -> Pid ! {self(), [A21, A22], [B11, B21]}
end,
receive
	{AB21} -> Pid ! {self(), [A21, A22], [B12, B22], stop}
end,
receive
	{AB22} -> [[AB11, AB12],[AB21, AB22]]
end.

scalar_product_sp() ->
	receive
		{Pid, Row, Col, stop} ->
			Pid ! {scalar_product(Row,Col)};
		{Pid, Row, Col} ->
			Pid ! {scalar_product(Row,Col)},
			scalar_product_sp()
	end.

%testing mat_mul
%mat_mul_nospawn([[A11, A12], [A21, A22]], [[B11, B12], [B21, B22]]) ->
%[[scalar_product([A11, A12], [B11, B21]), scalar_product([A11, A12], [B12, B22])],
%[scalar_product([A21, A22], [B11, B21]), scalar_product([A21, A22], [B12, B22])]].

%mat_mul_test(A, B) -> mat_mul(A,B) == mat_mul_nospawn(A,B).


