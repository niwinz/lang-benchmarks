defmodule Benchmark do
    def generate_list(numberLists, numberItems) do
        lc _ inlist Enum.to_list(0 .. numberLists) do
            lc _ inlist Enum.to_list(0 .. numberItems) do
               :random.uniform(100)
            end
        end
    end

    defp calculate_list(list) do
        List.foldr(list, 0, &(&1 + &2))
    end

    def do_bench(input) do
        calculate_list Enum.map input, &calculate_list/1
    end

    def main(args) do
        [arg1, arg2 | _] = args
        {numberLists, _} = Integer.parse(arg1)
        {numberItems, _} = Integer.parse(arg2)
        list = generate_list(numberLists, numberItems)
        {elapsed, result} = :timer.tc(&do_bench/1, [list])
        IO.puts "[Elixir ! Array Sum] Elapsed time: #{elapsed/1000} msec ( Result: #{result} )"
    end
end

Benchmark.main(System.argv())
