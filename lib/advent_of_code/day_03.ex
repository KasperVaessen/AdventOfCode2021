defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Grid

  def part1(args) do
    grid = Grid.read_grid(args)

    {gamma, epsilon} =
      0..(grid.cols - 1)
      |> Enum.map(&Enum.frequencies(Grid.get_col(grid, &1)))
      |> Enum.reduce(
        {"", ""},
        fn %{"0" => counts0, "1" => counts1}, {gamma, epsilon} ->
          if counts0 > counts1 do
            {gamma <> "0", epsilon <> "1"}
          else
            {gamma <> "1", epsilon <> "0"}
          end
        end
      )

    String.to_integer(gamma, 2) * String.to_integer(epsilon, 2)
  end

  defp find_value(grid, col, cmp_func) do
    if grid.rows == 1 do
      Grid.get_row(grid, 0) |> Enum.join() |> String.to_integer(2)
    else
      %{"0" => counts0, "1" => counts1} = Enum.frequencies(Grid.get_col(grid, col))

      new_grid =
        if cmp_func.(counts0, counts1) do
          Grid.filter_rows(grid, &(elem(&1, col) == "0"))
        else
          Grid.filter_rows(grid, &(elem(&1, col) == "1"))
        end

      find_value(new_grid, col + 1, cmp_func)
    end
  end

  def part2(args) do
    grid = Grid.read_grid(args)

    find_value(grid, 0, &(&1 > &2)) * find_value(grid, 0, &(&1 <= &2))
  end
end
