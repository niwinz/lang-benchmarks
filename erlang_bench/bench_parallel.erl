% Erlang benchmark
-module(bench_parallel).
-export([main/0, benchmark/1]).

% Calculate the aggregate of the sums of the sublists
gatherAdd([Child|L]) ->
    receive
        {Child, Ret} -> Ret + gatherAdd(L)
    end;
gatherAdd([]) -> 0.

benchmark(List) ->
    S = self(),
    Sum = fun(A,B)-> A + B end,
    Accum = fun(Parent, L) -> Parent ! {self(), lists:foldr(Sum, 0, L)} end,
    Pids = lists:map(fun(I)-> spawn(fun()->Accum(S, I) end) end, List),
    gatherAdd(Pids).

% Generate a list of random intenger lists
generate_list() ->
    [[ random:uniform(100) || _  <- lists:seq(1, 500)] || _ <- lists:seq(1,100)].

% Execute main method
main() ->
    List = generate_list(),
    {ElapsedMicro, Result} = timer:tc(bench_parallel, benchmark, [List]),
    Elapsed = ElapsedMicro / 1000,
    io:fwrite("[Erlang ! Parallel Sum]: Elapsed time: ~p msec ( Result: ~p )\n", [Elapsed, Result]).

