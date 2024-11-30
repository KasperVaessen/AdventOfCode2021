defmodule AdventOfCode.Day02 do
  alias AdventOfCode.Grid

  def part1(args) do
    mapper =
      %{
        "forward" => {1, 0},
        "down" => {0, 1},
        "up" => {0, -1}
      }

    grid = Grid.read_grid(args, " ")

    {pos_x, pos_y} =
      grid.data
      |> Tuple.to_list()
      |> Enum.reduce({0, 0}, fn {dir, amount}, {x, y} ->
        {dir_x, dir_y} = mapper[dir]
        amount = String.to_integer(amount)
        {x + dir_x * amount, y + dir_y * amount}
      end)

    pos_x * pos_y
  end

  def part2(args) do
    mapper =
      %{
        "forward" => {1, 1, 0},
        "down" => {0, 0, 1},
        "up" => {0, 0, -1}
      }

    grid = Grid.read_grid(args, " ")

    {pos_x, pos_y, _} =
      grid.data
      |> Tuple.to_list()
      |> Enum.reduce({0, 0, 0}, fn {dir, amount}, {x, y, aim} ->
        {dir_x, dir_y, dir_aim} = mapper[dir]
        amount = String.to_integer(amount)
        {x + amount * dir_x, y + dir_y * amount * aim, aim + amount * dir_aim}
      end)

    pos_x * pos_y
  end
end
