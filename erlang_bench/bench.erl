% Erlang benchmark
-module(bench).
-export([main/0, benchmark/1]).

% Calculate the aggregate of the sums of the sublists
benchmark(List) ->
    Sum = fun(A,B)-> A + B end,
    Accum = fun(L) -> lists:foldr(Sum, 0, L) end,
    Accum(lists:map(Accum, List)).

% Generate a list of random intenger lists
generate_list() ->
    [[ random:uniform(100) || _  <- lists:seq(1, 500)] || _ <- lists:seq(1,100)].

% Execute main method
main() ->
    List = generate_list(),
    {ElapsedMicro, Result} = timer:tc(bench, benchmark, [List]),
    Elapsed = ElapsedMicro / 1000,
    io:fwrite("[Erlang ! Array Sum]: Elapsed time: ~p msec ( Result: ~p )\n", [Elapsed, Result]).

