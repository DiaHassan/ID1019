defmodule Hanoi do

  def test(n) do
    hanoi(n, :h, :m, :k)
  end

  def hanoi(0, _, _, _) do [] end
  def hanoi(n, from, mid, finish) do
    hanoi(n-1, from, finish, mid) ++ [{:move, from, finish}] ++ hanoi(n-1, mid, from, finish)
  end

end
