# Activity 5.2 Parallel and concurrent programming
# Elixir example without parallelism (sequential)
# Paulina Cortez | A01782041
# June 03, 2026

#Probelm 1: Factorial
defmodule Sequential do
    #we convert all the decimal number to their binary form
    def binary(0), do: "0"
    def binary(n), do: binary_convert(n, "")

    # base case for using recursion to building the string in binary
  defp binary_convert(0, accumulator), do: accumulator
  defp binary_convert(n, accumulator) do
    bit = rem(n, 2)
    binary_convert(div(n, 2), "#{bit}" <> accumulator)
  end

  #we count the amount of 1 in the string
  defp count_ones(binary_str) do
    Enum.reduce(String.graphemes(binary_str), 0, fn char, accumulator -> if char == "1", do: accumulator + 1, else: accumulator
    end)
  end

  #return the amount and show
  def factorial_one_bits(n) do
    factorial = Enum.reduce(1..n, 1, fn i, accumulator -> accumulator * i end)
    binary_str = binary(factorial)
    count_ones(binary_str)
  end

  #PRoblem 2: Prime numbers
  # we revise if the number has any odd divisors to determine how to proceed
  defp check_div(_x, i, limit) when i > limit, do: true
  defp check_div(x, i, limit) do
    if rem(x, i)==0 do false
    else
      check_div(x, i+2, limit)
    end
  end

  #we define a set of rules to check if the number is prime and can be checked
  defp is_prime?(x) when x<2, do: false
  defp is_prime?(2), do: true
  defp is_prime?(x) when rem(x, 2) == 0, do: false
  defp is_prime?(x) do
    limit = trunc(:math.sqrt(x))
    check_div(x, 3, limit)
  end

  #we perform de addition of all the numbers in a range of 2 (that was set previously)
  def prime_sum(n) do
    Enum.reduce(2..n, 0, fn x, accumulator ->
      if is_prime?(x), do: accumulator + x, else: accumulator
    end)
  end

  #Problem 3: Pi approximation
  def compute_pi(n) do
    width = 1.0/n

    sum = Enum.reduce(0..(n - 1), 0.0, fn i, accumulator ->
        half = (i + 0.5)*width
        height = 4.0/(1.0 + half * half)
        accumulator + height
      end)

    width * sum
  end

end
