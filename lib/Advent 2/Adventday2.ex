defmodule Advent do

  def first_way(turn) do
    case turn do
      "A X" -> 1 + 3
      "A Y" -> 2 + 6
      "A Z" -> 3 + 0

      "B X" -> 1 + 0
      "B Y" -> 2 + 3
      "B Z" -> 3 + 6

      "C X" -> 1 + 6
      "C Y" -> 2 + 0
      "C Z" -> 3 + 3
    end
  end

  def second_way(turn) do
    case turn do
      "A X" -> 3 + 0
      "A Y" -> 1 + 3
      "A Z" -> 2 + 6

      "B X" -> 1 + 0
      "B Y" -> 2 + 3
      "B Z" -> 3 + 6

      "C X" -> 2 + 0
      "C Y" -> 3 + 3
      "C Z" -> 1 + 6
    end
  end

  def read_first do
    {:ok, body} = File.read("C:/Users/hassa/OneDrive/Documents/Elixier/test/lib/Advent 2/turns.csv")
    list = String.split(body, "\r\n")
    new_list = Enum.map(list, fn(x) -> first_way(x) end)
    Enum.reduce(new_list, 0, &(&1 + &2))
  end
  def read_second do
    {:ok, body} = File.read("C:/Users/hassa/OneDrive/Documents/Elixier/test/lib/Advent 2/turns.csv")
    list = String.split(body, "\r\n")
    new_list = Enum.map(list, fn(x) -> second_way(x) end)
    Enum.reduce(new_list, 0, &(&1 + &2))
  end
end
