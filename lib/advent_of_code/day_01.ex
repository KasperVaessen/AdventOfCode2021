defmodule AdventOfCode.Day01 do
  def part1(args) do
    String.split(args, ["\n", "\r", "\r\n"], trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [x1, x2] -> x2 > x1 end)
  end

  def part2(args) do
    String.split(args, ["\n", "\r", "\r\n"], trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum(&1))
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [x1, x2] -> x2 > x1 end)
  end
end
