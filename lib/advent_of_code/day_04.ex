defmodule AdventOfCode.Day04 do
  alias AdventOfCode.Grid

  def part1(args) do
    [numbers | boards] = args |> String.split(["\n\n", "\r\r", "\r\n\r\n"], trim: true)

    numbers = String.split(numbers, ",", trim: true) |> Enum.map(&String.to_integer/1)
    boards = Enum.map(boards, fn board -> Grid.read_grid(board, " ", &String.to_integer/1) end)

    Enum.reduce_while(numbers, boards, fn num, boards ->
      new_boards =
        Enum.map(boards, fn board ->
          Grid.map(
            board,
            &if num != &1 do
              &1
            end
          )
        end)

      case check_win(new_boards, num) do
        :no_win ->
          {:cont, new_boards}

        {:win, score, _} ->
          {:halt, score}
      end
    end)
  end

  def part2(args) do
    [numbers | boards] = args |> String.split(["\n\n", "\r\r", "\r\n\r\n"], trim: true)

    numbers = String.split(numbers, ",", trim: true) |> Enum.map(&String.to_integer/1)
    boards = Enum.map(boards, fn board -> Grid.read_grid(board, " ", &String.to_integer/1) end)

    Enum.reduce_while(numbers, boards, fn num, boards ->
      new_boards =
        Enum.map(boards, fn board ->
          Grid.map(
            board,
            &if num != &1 do
              &1
            end
          )
        end)

      case check_win(new_boards, num) do
        :no_win ->
          {:cont, new_boards}

        {:win, score, remaining_boards} ->
          if Enum.empty?(remaining_boards) do
            {:halt, score}
          else
            {:cont, remaining_boards}
          end
      end
    end)
  end

  defp check_win(boards, num) do
    result =
      Enum.map(boards, fn board ->
        rows_filtered =
          Grid.filter_rows(board, fn row -> Tuple.to_list(row) |> Enum.all?(&is_nil/1) end)

        cols_filtered =
          Grid.filter_cols(board, fn col -> Tuple.to_list(col) |> Enum.all?(&is_nil/1) end)

        if rows_filtered.rows > 0 or cols_filtered.cols > 0 do
          sum = board |> Grid.to_iterable() |> Enum.reject(&is_nil/1) |> Enum.sum()
          {:win, sum * num}
        else
          board
        end
      end)

    remaining_boards =
      Enum.filter(result, fn
        {:win, _} -> false
        _ -> true
      end)

    win =
      Enum.filter(result, fn
        {:win, _} -> true
        _ -> false
      end)

    if win == [] do
      :no_win
    else
      {:win, elem(hd(win), 1), remaining_boards}
    end
  end
end
