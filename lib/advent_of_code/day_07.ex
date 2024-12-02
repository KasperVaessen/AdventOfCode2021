defmodule AdventOfCode.Day07 do
  alias AdventOfCode.Grid

  def part1(args) do
    positions =
      Grid.read_grid(args, ",", &String.to_integer/1)
      |> Grid.get_row(0)
      |> Enum.sort()

    middle_index = positions |> length() |> div(2)

    pos = Enum.at(positions, middle_index)

    Enum.map(positions, &abs(&1 - pos)) |> Enum.sum()
  end

  def part2(args) do
    positions =
      Grid.read_grid(args, ",", &String.to_integer/1)
      |> Grid.get_row(0)

    min = Enum.min(positions)
    max = Enum.max(positions)

    Enum.reduce(min..max, Float.max_finite(), fn pos, curr_lowest ->
      val = fun(positions, pos)

      min(val, curr_lowest)
    end)
  end

  def fun(positions, x) do
    Enum.map(positions, &(abs(&1 - x) * (abs(&1 - x) + 1) / 2)) |> Enum.sum()
  end
end
