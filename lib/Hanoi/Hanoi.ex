defmodule Hanoi do

  def test(n) do
    hanoi(n, :a, :b, :c)
  end

  def hanoi(0, _, _, _) do [] end
  def hanoi(n, first, second, third) do
    hanoi(n-1, first, third, second) ++ [{:move, first, third}] ++ hanoi(n-1, second, first, third)
  end

end
