% Erlang benchmark
-module(bench_parallel).
-export([main/0, benchmark/1]).

% Calculate the aggregate of the sums of the sublists
benchmark(List) ->
    Self = self(),
    Sum = fun(A,B)-> A + B end,
    ChildProcess = fun(Parent, ChildList) -> Parent ! lists:foldr(Sum, 0, ChildList) end,
    Pids = lists:map(fun(Input)-> spawn(fun()->ChildProcess(Self, Input) end) end, List),
    AccumulateChildResult = fun(_, Val) -> receive Ret -> Val + Ret end end,
    lists:foldr(AccumulateChildResult, 0, Pids).

% Generate a list of random intenger lists
generate_list() ->
    [[ random:uniform(100) || _  <- lists:seq(1, 500)] || _ <- lists:seq(1,100)].

% Execute main method
main() ->
    List = generate_list(),
    {ElapsedMicro, Result} = timer:tc(bench_parallel, benchmark, [List]),
    Elapsed = ElapsedMicro / 1000,
    io:fwrite("[Erlang ! Parallel Sum]: Elapsed time: ~p msec ( Result: ~p )\n", [Elapsed, Result]).

