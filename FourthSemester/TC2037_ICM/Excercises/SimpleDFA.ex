#Simple DFA
#Paulina Cortez Balvanera | A01782041
#April 21, 2026

defmodule SimpleDFA do
def dfa_parser(string, {delta, q0, accept}) do
    string
    |>String.graphemes()
    |>dfa_step(delta, q0, accept)
end

    #recusivo
    def dfa_step([], _delta, state, accept), do:
        Enum.member?(accept, state)
    def dfa_step([head | tail], delta, state, accept) do
        dfa_step(tail, delta, delta.(state, head), accept)
    end


def delta_a_dc_b(state, char) do
        case state do
            :q0 -> case char do
                "a" -> :q1
                # We don't care for any other value. They are all errors.
                _ -> :err
            end

            :q1 -> case char do
                "a" -> :q1
                "b" -> :q1
                "c" -> :q1
                "d" -> :q2
                _ -> :err
            end

            :q2 -> case char do
                "a" -> :q1
                "b" -> :q1
                "c" -> :q3
                "d" -> :q1
                _ -> :err
            end

            :q3 -> case char do
                "a" -> :q3
                "b" -> :q4
                "c" -> :q3
                "d" -> :q3
                _ -> :err
            end

            :q4 -> case char do
                "a" -> :q3
                "b" -> :q4
                "c" -> :q3
                "d" -> :q3
                _ -> :err
            end

            :err -> :err
        end

#iex> SimpleDFA.dfa_parser("abdcdbdab", {&SimpleDFA.delta_a_dc_b/2, :q0,[:q4]})
end
end
