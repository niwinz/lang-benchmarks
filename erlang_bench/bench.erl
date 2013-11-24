% Erlang benchmark
-module(bench).
-export([main/1, benchmark/1]).

% Calculate the aggregate of the sums of the sublists
benchmark(List) ->
    Sum = fun(A,B)-> A + B end,
    Accum = fun(L) -> lists:foldr(Sum, 0, L) end,
    Accum(lists:map(Accum, List)).

% Generate a list of random intenger lists
generate_list(ListSize, NumberSize) ->
    [[ random:uniform(100) || _  <- lists:seq(1, NumberSize)] || _ <- lists:seq(1,ListSize)].

% Execute main method
main(Args) ->
    % Parse input args
    [Arg1 , Arg2 | _] = Args,
    {ListSize, _} = string:to_integer(atom_to_list(Arg1)),
    {NumberSize, _} = string:to_integer(atom_to_list(Arg2)),

    % Call the algorithm
    List = generate_list(ListSize, NumberSize),
    {ElapsedMicro, Result} = timer:tc(bench, benchmark, [List]),
    Elapsed = ElapsedMicro / 1000,
    io:fwrite("[Erlang ! Array Sum]: Elapsed time: ~p msec ( Result: ~p )\n", [Elapsed, Result]).

