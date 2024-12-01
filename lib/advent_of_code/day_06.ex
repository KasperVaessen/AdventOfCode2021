defmodule AdventOfCode.Day06 do
  alias AdventOfCode.Grid

  def part1(args) do
    grow(args, 80)
  end

  def part2(args) do
    grow(args, 256)
  end

  defp grow(args, steps) do
    amounts =
      Grid.read_grid(args, ",", &String.to_integer/1)
      |> Grid.get_row(0)
      |> Enum.frequencies()

    amounts = Map.merge(Enum.map(0..7, &{&1, 0}) |> Map.new(), amounts)

    fishes =
      Enum.reduce(1..steps, amounts, fn _, acc ->
        num_new = acc[0]

        acc
        |> Enum.map(fn {age, num} ->
          if age == 0 do
            {6, num}
          else
            {age - 1, num}
          end
        end)
        |> Enum.reduce(%{}, fn {age, num}, res ->
          Map.update(res, age, num, &(&1 + num))
        end)
        |> Map.new()
        |> Map.put(8, num_new)
      end)

    Enum.reduce(fishes, 0, fn {_key, num}, acc -> num + acc end)
  end
end
