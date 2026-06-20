# Gilberto Echeverria
# 2024-05-15

Code.require_file("token_list.ex")
ExUnit.start()
defmodule TokenListTest do
  use ExUnit.Case
  alias TokenList

  describe "basic tokens" do
    # Comment the describetag line to run this set of tests
    # @describetag :skip
    test "invalid expression", do: assert(TokenList.arithmetic_lexer("3-") == false)

    test "single int", do: assert(TokenList.arithmetic_lexer("37") == [{:int, "37"}])

    test "single float", do: assert(TokenList.arithmetic_lexer("3.7") == [{:float, "3.7"}])

    test "two dots together", do: assert(TokenList.arithmetic_lexer("3..7") == false)

    test "invalid float", do: assert(TokenList.arithmetic_lexer("3.9.7") == false)

    test "int exponential", do: assert(TokenList.arithmetic_lexer("3e4") == [{:exp, "3e4"}])

    test "int negative exponential",
      do: assert(TokenList.arithmetic_lexer("3e-4") == [{:exp, "3e-4"}])

    test "int Exponential", do: assert(TokenList.arithmetic_lexer("3E4") == [{:exp, "3E4"}])

    test "int negative Exponential",
      do: assert(TokenList.arithmetic_lexer("3E-4") == [{:exp, "3E-4"}])

    test "float exponential",
      do: assert(TokenList.arithmetic_lexer("3.8e4") == [{:exp, "3.8e4"}])

    test "float negative exponential",
      do: assert(TokenList.arithmetic_lexer("3.8e-4") == [{:exp, "3.8e-4"}])

    test "invalid exponential 1", do: assert(TokenList.arithmetic_lexer("3e*4") == false)

    test "invalid exponential 2", do: assert(TokenList.arithmetic_lexer("6e") == false)

    test "invalid exponential 3", do: assert(TokenList.arithmetic_lexer("6.2e") == false)

    test "invalid exponential 4", do: assert(TokenList.arithmetic_lexer("6.2e2.4") == false)

    test "invalid exponential 5", do: assert(TokenList.arithmetic_lexer("6.2e*2") == false)

    test "single variable", do: assert(TokenList.arithmetic_lexer("value") == [{:var, "value"}])

    test "wrong variable", do: assert(TokenList.arithmetic_lexer("34value") == false)

    test "variable start with underscore",
      do: assert(TokenList.arithmetic_lexer("_value") == [{:var, "_value"}])

    test "variable with underscore",
      do: assert(TokenList.arithmetic_lexer("next_value") == [{:var, "next_value"}])

    test "variable with underscore and numbers",
      do: assert(TokenList.arithmetic_lexer("_2value5") == [{:var, "_2value5"}])
  end

  describe "basic expressions" do
    # Comment the describetag line to run this set of tests
    # @describetag :skip
    test "simple subtraction",
      do: assert(TokenList.arithmetic_lexer("3-2") == [{:int, "3"}, {:oper, "-"}, {:int, "2"}])

    test "valid expression negative numbers",
      do:
        assert(TokenList.arithmetic_lexer("-3+-2") == [{:int, "-3"}, {:oper, "+"}, {:int, "-2"}])

    test "valid expression positive numbers",
      do:
        assert(
          TokenList.arithmetic_lexer("+3/-2*7++5") == [
            {:int, "+3"},
            {:oper, "/"},
            {:int, "-2"},
            {:oper, "*"},
            {:int, "7"},
            {:oper, "+"},
            {:int, "+5"}
          ]
        )

    test "invalid expression start with operator",
      do: assert(TokenList.arithmetic_lexer("*53") == false)

    test "invalid expression end with operator",
      do: assert(TokenList.arithmetic_lexer("5-3+") == false)

    test "invalid expression consecutive operators",
      do: assert(TokenList.arithmetic_lexer("5-/3") == false)

    test "multiple ints, float, operators",
      do:
        assert(
          TokenList.arithmetic_lexer("4+2.3-5=1.2") == [
            {:int, "4"},
            {:oper, "+"},
            {:float, "2.3"},
            {:oper, "-"},
            {:int, "5"},
            {:oper, "="},
            {:float, "1.2"}
          ]
        )

    test "expression with variables",
      do:
        assert(
          TokenList.arithmetic_lexer("done=well+good") == [
            {:var, "done"},
            {:oper, "="},
            {:var, "well"},
            {:oper, "+"},
            {:var, "good"}
          ]
        )

    test "expression with variables and numbers",
      do:
        assert(
          TokenList.arithmetic_lexer("done=34.4/well+good*86") == [
            {:var, "done"},
            {:oper, "="},
            {:float, "34.4"},
            {:oper, "/"},
            {:var, "well"},
            {:oper, "+"},
            {:var, "good"},
            {:oper, "*"},
            {:int, "86"}
          ]
        )

    test "expression with variables, underscores and numbers",
      do:
        assert(
          TokenList.arithmetic_lexer("_done=34.4/we_ll+good_*86") == [
            {:var, "_done"},
            {:oper, "="},
            {:float, "34.4"},
            {:oper, "/"},
            {:var, "we_ll"},
            {:oper, "+"},
            {:var, "good_"},
            {:oper, "*"},
            {:int, "86"}
          ]
        )

    test "invalid variables",
      do: assert(TokenList.arithmetic_lexer("done=34.4/well64+66good_*86") == false)

    test "missing operator between variables",
      do: assert(TokenList.arithmetic_lexer("not right") == false)

    test "missing operator between numbers",
      do: assert(TokenList.arithmetic_lexer("3456 9987") == false)

    test "double operator between numbers",
      do: assert(TokenList.arithmetic_lexer("3456-*9987") == false)
  end

  describe "parentheses" do
    # Comment the describetag line to run this set of tests
    # @describetag :skip
    test "open at the beginning",
      do: assert(TokenList.arithmetic_lexer("(38") == [{:par_open, "("}, {:int, "38"}])

    test "close at the end",
      do: assert(TokenList.arithmetic_lexer("38)") == [{:int, "38"}, {:par_close, ")"}])

    test "open and close",
      do:
        assert(
          TokenList.arithmetic_lexer("(38)") == [
            {:par_open, "("},
            {:int, "38"},
            {:par_close, ")"}
          ]
        )

    test "open at the end",
      do: assert(TokenList.arithmetic_lexer(")38") == false)

    test "close at the beginning",
      do: assert(TokenList.arithmetic_lexer("38(") == false)

    test "open after operator",
      do:
        assert(
          TokenList.arithmetic_lexer("3+(38") == [
            {:int, "3"},
            {:oper, "+"},
            {:par_open, "("},
            {:int, "38"}
          ]
        )

    test "close before operator",
      do:
        assert(
          TokenList.arithmetic_lexer("38)-6") == [
            {:int, "38"},
            {:par_close, ")"},
            {:oper, "-"},
            {:int, "6"}
          ]
        )

    test "open before operator",
      do: assert(TokenList.arithmetic_lexer("4(*38") == false)

    test "close after operator",
      do: assert(TokenList.arithmetic_lexer("38+)8") == false)

    test "nested parentheses",
      do:
        assert(
          TokenList.arithmetic_lexer("((2-6))") == [
            {:par_open, "("},
            {:par_open, "("},
            {:int, "2"},
            {:oper, "-"},
            {:int, "6"},
            {:par_close, ")"},
            {:par_close, ")"}
          ]
        )
  end

  describe "expressions with spaces" do
    # Comment the describetag line to run this set of tests
    # @describetag :skip
    test "single spaces around operators",
      do:
        assert(TokenList.arithmetic_lexer("38 - 2") == [{:int, "38"}, {:oper, "-"}, {:int, "2"}])

    test "spaces at the beginning",
      do:
        assert(
          TokenList.arithmetic_lexer(" 38 - 2 ") == [{:int, "38"}, {:oper, "-"}, {:int, "2"}]
        )

    test "double operator between numbers, with spaces",
      do: assert(TokenList.arithmetic_lexer("3456 - * 9987") == false)

    test "double operator between variables, with spaces",
      do: assert(TokenList.arithmetic_lexer("one - * two") == false)

    test "spaces and variables",
      do:
        assert(
          TokenList.arithmetic_lexer("res = 38 - 2") == [
            {:var, "res"},
            {:oper, "="},
            {:int, "38"},
            {:oper, "-"},
            {:int, "2"}
          ]
        )

    test "spaces, floats and variables",
      do:
        assert(
          TokenList.arithmetic_lexer("res = 38 - 2.46") == [
            {:var, "res"},
            {:oper, "="},
            {:int, "38"},
            {:oper, "-"},
            {:float, "2.46"}
          ]
        )

    test "open before operator, with spaces",
      do: assert(TokenList.arithmetic_lexer("4 ( * 38") == false)

    test "close after operator, with spaces",
      do: assert(TokenList.arithmetic_lexer("38 + ) 8") == false)
  end

  describe "complete expressions" do
    # Comment the describetag line to run this set of tests
    #@describetag :skip
    test "full test 1",
      do:
        assert(
          TokenList.arithmetic_lexer("(38 - 2) * 5") == [
            par_open: "(",
            int: "38",
            oper: "-",
            int: "2",
            par_close: ")",
            oper: "*",
            int: "5"
          ]
        )

    test "full test 2",
      do:
        assert(
          TokenList.arithmetic_lexer("res = (38.24 - one) * 5 - 2.3e-5") == [
            var: "res",
            oper: "=",
            par_open: "(",
            float: "38.24",
            oper: "-",
            var: "one",
            par_close: ")",
            oper: "*",
            int: "5",
            oper: "-",
            exp: "2.3e-5"
          ]
        )

    test "full test 3",
      do:
        assert(
          TokenList.arithmetic_lexer("res   = (  38.24 - one ) * 5 - (2.3e-5/toy)") == [
            var: "res",
            oper: "=",
            par_open: "(",
            float: "38.24",
            oper: "-",
            var: "one",
            par_close: ")",
            oper: "*",
            int: "5",
            oper: "-",
            par_open: "(",
            exp: "2.3e-5",
            oper: "/",
            var: "toy",
            par_close: ")"
          ]
        )

    test "full test 4",
      do:
        assert(
          TokenList.arithmetic_lexer("_done = 34.4 / we_ll + good_ * 86") == [
            {:var, "_done"},
            {:oper, "="},
            {:float, "34.4"},
            {:oper, "/"},
            {:var, "we_ll"},
            {:oper, "+"},
            {:var, "good_"},
            {:oper, "*"},
            {:int, "86"}
          ]
        )

    test "full test 5, quadratic formula",
      do:
        assert(
          TokenList.arithmetic_lexer("root = (-b + (b^2 - 4 * a * c)^(0.5)) / (2 * a)") == [
            var: "root",
            oper: "=",
            par_open: "(",
            var: "-b",
            oper: "+",
            par_open: "(",
            var: "b",
            oper: "^",
            int: "2",
            oper: "-",
            int: "4",
            oper: "*",
            var: "a",
            oper: "*",
            var: "c",
            par_close: ")",
            oper: "^",
            par_open: "(",
            float: "0.5",
            par_close: ")",
            par_close: ")",
            oper: "/",
            par_open: "(",
            int: "2",
            oper: "*",
            var: "a",
            par_close: ")"
          ]
        )
  end

  describe "calls with DFA" do
    # Comment the describetag line to run this set of tests
    #@describetag :skip
    test "one variable",
      do:
        assert(
          TokenList.evaluate_3(
            {:start, [:int, :float, :var], &TokenList.delta_arithmetic/2},
            "asodin"
          ) == [{:var, "asodin"}]
        )

    test "invalid variable",
      do:
        assert(
          TokenList.evaluate_3(
            {:start, [:int, :float, :var], &TokenList.delta_arithmetic/2},
            "435oij"
          ) == false
        )

    test "single digit int",
      do:
        assert(
          TokenList.evaluate_3(
            {:start, [:int, :float, :var], &TokenList.delta_arithmetic/2},
            "5"
          ) == [{:int, "5"}]
        )

    test "multi digit int",
      do:
        assert(
          TokenList.evaluate_3(
            {:start, [:int, :float, :var], &TokenList.delta_arithmetic/2},
            "748"
          ) == [{:int, "748"}]
        )

    test "expression with float, operator and int",
      do:
        assert(
          TokenList.evaluate_3(
            {:start, [:int, :float, :var], &TokenList.delta_arithmetic/2},
            "7.4/8"
          ) == [{:float, "7.4"}, {:oper, "/"}, {:int, "8"}]
        )
  end
end
