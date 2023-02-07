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

  def double_five_animal([head | tail], f_case) do
    case f_case do
        :double -> [2 * head | double_five_animal(tail, f_case)]
        :five -> [5 + head | double_five_animal(tail, f_case)]
        :animal ->
            if (head == :dog) do
              [:fido | double_five_animal(tail, f_case)]
          else
            [head | double_five_animal(tail, f_case)]
        end
      end
  end

  def apply_to_all([], _) do [] end
  def apply_to_all([head | tail], f) do
    [f.(head) | apply_to_all(tail, f)]
  end

  def sum([]) do 0 end
  def sum( [head | tail] ) do
    head + sum(tail)
  end

  def fold_right([], ini, _ ) do ini end
  def fold_right([head | tail], ini, f ) do
    f.(head, fold_right(tail, ini, f))
  end

  def fold_left([], ini, _) do ini end
  def fold_left([head|tail], ini, f) do
    fold_left(tail, f.(head, ini), f)
  end


  def odd( [] ) do [] end
  def odd([head | tail]) do
    if rem(head,2) == 1 do
      [head | odd(tail)]
    else
      odd(tail)
    end
  end

  def filter([], _) do [] end
  def filter([head | tail], f) do
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

end
