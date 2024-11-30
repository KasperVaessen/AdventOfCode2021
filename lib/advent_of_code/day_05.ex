defmodule AdventOfCode.Day05 do
  alias AdventOfCode.Grid

  def part1(args) do
    count_overlap(args, false)
  end

  def part2(args) do
    count_overlap(args, true)
  end

  defp count_overlap(args, part_2?) do
    grid =
      Grid.read_grid(args, " -> ", fn coords ->
        String.split(coords, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end)

    grid.data
    |> Tuple.to_list()
    |> Enum.flat_map(&points_between(&1, part_2?))
    |> Enum.frequencies()
    |> Enum.count(fn {_key, val} -> val >= 2 end)
  end

  defp points_between({{x1, y1}, {x2, y2}}, _) when x1 == x2 do
    Enum.map(y1..y2, &{x1, &1})
  end

  defp points_between({{x1, y1}, {x2, y2}}, _) when y1 == y2 do
    Enum.map(x1..x2, &{&1, y1})
  end

  defp points_between({{x1, y1}, {x2, y2}}, true) do
    Enum.zip(x1..x2, y1..y2)
  end

  defp points_between({{_x1, _y1}, {_x2, _y2}}, false), do: []
end
