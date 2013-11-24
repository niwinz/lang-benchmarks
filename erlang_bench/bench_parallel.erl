% Erlang benchmark
-module(bench_parallel).
-export([main/1, benchmark/1]).

% Calculate the aggregate of the sums of the sublists
benchmark(List) ->
    Self = self(),
    Sum = fun(A,B)-> A + B end,
    ChildProcess = fun(Parent, ChildList) -> Parent ! lists:foldr(Sum, 0, ChildList) end,
    Pids = lists:map(fun(Input)-> spawn(fun()->ChildProcess(Self, Input) end) end, List),
    AccumulateChildResult = fun(_, Val) -> receive Ret -> Val + Ret end end,
    lists:foldr(AccumulateChildResult, 0, Pids).

% Generate a list of random intenger lists
generate_list(ListSize, NumberSize) ->
    [[ random:uniform(100) || _  <- lists:seq(1, NumberSize)] || _ <- lists:seq(1,ListSize)].

% Execute main method
main(Args) ->
    % Parse input args
    [Arg1 , Arg2 | _] = Args,
    {ListSize, _} = string:to_integer(atom_to_list(Arg1)),
    {NumberSize, _} = string:to_integer(atom_to_list(Arg2)),

    List = generate_list(ListSize, NumberSize),
    {ElapsedMicro, Result} = timer:tc(bench_parallel, benchmark, [List]),
    Elapsed = ElapsedMicro / 1000,
    io:fwrite("[Erlang ! Parallel Sum]: Elapsed time: ~p msec ( Result: ~p )\n", [Elapsed, Result]).

