defmodule Higher do
  def double([]) do [] end
  def double([head | tail]) do
    [head*2 | double(tail)]
  end

  def five([]) do [] end
  def five([head | tail]) do
    [head + 5 | five(tail)]
  end

  def animal([]) do [] end
  def animal([head | tail]) do
    if head == :dog do
      [:fido | animal(tail)]
    else
      [head | animal(tail)]
    end
  end

  def double_five_animal( [], _) do [] end
  def double_five_animal( [head | tail], f_case) do
    case f_case do
    :double -> double([head | tail])
    :five -> five([head | tail])
    :animal -> animal([head | tail])
    end
  end
end
