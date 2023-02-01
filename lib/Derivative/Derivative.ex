defmodule Der do
#Types
  @type literal() :: {:num, number()}
    | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
    | {:mul, expr(), expr()}
    | literal()
    | {:exp, expr(), literal()}
    | {:ln, expr()}
    | {:subtract, expr(),expr()}
    | {:fraction, expr(), expr()}
    | {:sqrt, expr()}
    | {:sin, expr()}
    | {:cos, expr()}


#TESTS
  def test1() do
    e = {:add,
    {:mul, {:num, 2}, {:var, :x}},
    {:num, 4}
    }
    d = deriv(e, :x)
    IO.write("epxression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    # pprint(d)
    :ok
  end

  def test2() do
    e = {:add,
    {:exp, {:var, :x}, {:num, 3}},
    {:num, 4}
    }
    d = deriv(e, :x)
    IO.write("epxression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    # pprint(d)
    :ok
  end
  def test3() do
    e = {:add,
          {:ln,
            {:exp, {:var, :x}, {:num, 2}}},
          {:num, 3}
        }
    d = deriv(e, :x)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
  end

  def test5() do
    e = {:fraction, {:num, 2}, {:exp, {:var, :x}, {:num, 3}}}

    d = deriv(e, :x)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
  end
  def test6() do
    e = {:sqrt, {:var, :x}}

    d = deriv(e, :x)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
  end

  def test7() do
    e = {:cos, {:var, :x}}

    d = deriv(e, :x)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
  end

#Derivative
  def deriv({:num, _},_)   do {:num, 0} end
  def deriv({:var, v}, v)  do {:num, 1} end
  def deriv({:var, _}, _)  do {:num, 0} end
  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2, v)}
  end
  def deriv({:mul, e1, e2}, v) do
    {:add,
      {:mul, deriv(e1, v), e2},
      {:mul, e1, deriv(e2, v)}
    }
  end
  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
      deriv(e, v)
    }
  end
  def deriv({:ln, e}, v) do
    {:mul,
      {:fraction,{:num, 1},e},
      deriv(e, v)
  }
  end
  def deriv({:fraction, e1, e2}, v) do
    {:fraction,
      {:subtract,
        {:mul, deriv(e1, v), e2},
        {:mul, e1, deriv(e2, v)}},
    {:exp, e2, {:num, 2}}}
  end

  def deriv({:sqrt, e}, v) do
    {:mul,
      {:fraction,
        {:num, 1},
        {:mul,
          {:num, 2},
          {:sqrt, e}
        }
      }, deriv(e, v)
  }
  end

  def deriv({:sin, e}, v) do
    {:mul, deriv(e, v), {:cos, e}}

  end

  def deriv({:cos, e}, v) do
    {:mul, {:num, -1}, {:mul, deriv(e, v), {:sin, e}}}
  end

#Simplify
  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end
  def simplify({:subtract, e1, e2}) do
		simplify_sub(simplify(e1), simplify(e2))
	end
  def simplify({:frac, e1, e2}) do
		simplify_fraction(simplify(e1), simplify(e2))
	end


 def simplify(e) do e end

 def simplify_add({:num, 0}, e2) do e2 end
 def simplify_add(e1, {:num, 0}) do e1 end
 def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
 def simplify_add(e1,e2) do {:add, e1,e2} end

 #@spec simplify_mul(any, any) :: {:num, number}
 def simplify_mul({:num, 0},_) do {:num, 0} end
 def simplify_mul(_, {:num, 0}) do {:num, 0} end
 def simplify_mul({:num, 1}, e2) do e2 end
 def simplify_mul(e1, {:num, 1}) do e1 end
 def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
 def simplify_mul(e1,e2) do {:mul, e1,e2} end

 def simplify_exp(_, {:num, 0}) do {:num, 1} end
 def simplify_exp(e1, {:num, 1}) do e1 end
 def simplify_exp(e1, e2) do {:exp, e1, e2} end

 def simplify_sub(e1, {:num, 0}) do e1 end
 def simplify_sub({:num, n1}, {:num, n2}) do {:num, n1-n2} end
 def simplify_sub(e1,e2) do {:subtract, e1, e2} end

 def simplify_fraction(e1, e2) do {:fraction, e1, e2} end

#PPrint
  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1,e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:subtract, e1,e2}) do "(#{pprint(e1)} - #{pprint(e2)})" end
  def pprint({:mul, e1,e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
  def pprint({:exp, e1,e2}) do "(#{pprint(e1)}) ^ (#{pprint(e2)})" end
  def pprint({:ln, e}) do "(ln(#{pprint(e)}))" end
  def pprint({:fraction, e1, e2}) do "(#{pprint(e1)} / #{pprint(e2)})" end
  def pprint({:sqrt, e}) do "sqrt(#{pprint(e)})" end
  def pprint({:sin, e}) do "sin(#{pprint(e)})" end
  def pprint({:cos, e}) do "cos(#{pprint(e)})" end

end
