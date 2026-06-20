#Simple DFA
#Paulina Cortez Balvanera | A01782041
#April 21, 2026

defmodule TokenList do

  @digits ~w(0 1 2 3 4 5 6 7 8 9)
  @opers ~w(+ - * / % = ^)
  @identifiers ~w(a b c d e E f g h i j k l m n ñ o p q r s t u v w x y z _)

  def arithmetic_lexer(string) do
    dfa_parser(string, {&TokenList.delta_number/2, :start, [:int, :float, :exp, :var, :par_close, :int_space, :var_space]})
  end

  def evaluate_3({q0, accept, delta}, string) do
  dfa_parser(string, {delta, q0, accept})
end

def delta_arithmetic(state, char), do: delta_number(state, char)

  def dfa_parser(string, {delta, q0, accept}) do
    string
    |> String.graphemes()
    |> dfa_step(delta, q0, accept, [], "")
  end

  def dfa_step([head | tail], delta, state, accept, types, current) do
  [new_state, found] = delta.(state, head)
  if Enum.member?([:par_open, :par_close], new_state) do
    prev_tokens = if found do
        [{found, current} | types]
    else types
    end
    par_token = {new_state, head}
    dfa_step(tail, delta, new_state, accept, [par_token | prev_tokens], "")
else
    if found do
        token = case found do
            :int   -> {:int,current}
            :float -> {:float,current}
            :exp   -> {:exp, current}
            :var   -> {:var, current}
            :oper  -> {:oper, current}
            _ -> {found, current}
        end
        dfa_step(tail, delta, new_state, accept, [token | types], head)
    else
        new_current = if head == " ", do: current, else: current <> head
        dfa_step(tail, delta, new_state, accept, types, new_current)
    end
end
end

def dfa_step([], _delta, state, accept, types, current) do
  if Enum.member?(accept, state) do
    if current == "" do
      Enum.reverse(types)
    else
      token = case state do
        :int   -> {:int, current}
        :float -> {:float, current}
        :exp   -> {:exp, current}
        :var   -> {:var, current}
        :oper  -> {:oper, current}
        _      -> {state, current}
      end
      Enum.reverse([token | types])
    end
  else
    false
  end
end

  def delta_number(state, char) do
    case state do
      :start ->
        cond do
          char in ["+", "-"]   -> [:sign, false]
          char in @digits      -> [:int, false]
          char in @identifiers -> [:var, false]
          char in ["("]        -> [:par_open, false]
          char == " " -> [:start, false]
          true                 -> [:err, false]
        end

      :sign ->
        cond do
          char in @digits -> [:int, false]
          char in @identifiers -> [:var, false]
          true            -> [:err, false]
        end

      :int ->
        cond do
          char in ["."]        -> [:dot, false]
          char in ["e", "E"]   -> [:e, false]
          char in @digits      -> [:int, false]
          char in @opers       -> [:oper, :int]
          char in ["("]        -> [:par_open, :int]
          char in [")"]        -> [:par_close, :int]
          char in [" "] -> [:int_space, false]
          true                 -> [:err, false]
        end

      :dot ->
        cond do
          char in @digits -> [:float, false]
          true            -> [:err, false]
        end

      :float ->
        cond do
          char in ["e", "E"] -> [:e, false]
          char in @digits    -> [:float, false]
          char in @opers     -> [:oper, :float]
          char in ["("]      -> [:par_open, :float]
          char in [")"]      -> [:par_close, :float]
          char in [" "] -> [:float, false]
          true               -> [:err, false]
        end

      :e ->
        cond do
          char in ["+", "-"] -> [:e_sign, false]
          char in @digits    -> [:exp, false]
          true               -> [:err, false]
        end

      :e_sign ->
        cond do
          char in @digits -> [:exp, false]
          true            -> [:err, false]
        end

      :exp ->
        cond do
          char in @digits -> [:exp, false]
          char in @opers  -> [:oper, :exp]
          char in ["("]   -> [:par_open, false]
          char in [")"]   -> [:par_close, false]
          char in [" "] -> [:exp, false]
          true            -> [:err, false]
        end

      :oper ->
        cond do
          char in ["+", "-"] -> [:sign, :oper]
          char in @digits    -> [:int, :oper]
          char in @identifiers -> [:var, :oper]
          char in ["("]      -> [:par_open, false]
          char in [")"]      -> [:err, false]
          char in [" "] -> [:oper, false]
          true               -> [:err, false]
        end

      :var ->
        cond do
          char in @digits      -> [:var, false]
          char in @identifiers -> [:var, false]
          char in @opers -> [:oper, :var]
          char in [" "] -> [:var_space, false]
          true -> [:err, false]
        end

      :par_open ->
        cond do
          char in ["+", "-"] -> [:sign, false]
          char in @digits      -> [:int, false]
          char in @opers       -> [:oper, false]
          char in @identifiers -> [:var, false]
          char in ["("] -> [:par_open, false]
          true                 -> [:err, false]
        end

      :par_close ->
        cond do
          char in @digits      -> [:int, false]
          char in @opers       -> [:oper, false]
          char in @identifiers -> [:var, false]
          char in [")"] -> [:par_close, false]
          char in [" "] -> [:start, false]
          true -> [:err, false]
        end

        :int_space ->
            cond do
                char in @opers -> [:oper, :int]
                char in [")"] -> [:par_close, false]
                char in [" "]      -> [:int_space, false]
                true -> [:err, false]
            end
        :var_space ->
            cond do
                char in @opers -> [:oper, :var]
                char in [")"] -> [:par_close, false]
                char in [" "] -> [:var_space, false]
                true -> [:err, false]
            end
            :err -> [:err, false]
        end
    end
end
