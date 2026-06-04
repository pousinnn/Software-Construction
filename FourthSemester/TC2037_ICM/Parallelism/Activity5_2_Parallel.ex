# Activity 5.2 Parallel and concurrent programming
# Elixir example with parallelism
# Paulina Cortez | A01782041
# June 03, 2026

#Probelm 1: Factorial
defmodule Parallel do
#We will use a helper to start with an empty string and display the binary set through recursion
    def binary(0), do: "0"
    def binary(n), do: binary_convert(n,"")

    defp binary_convert(0, accumulator), do: accumulator #base case for recursion: stop process and return binary string
    defp binary_convert(n, accumulator) do
        bit=rem(n,2)
        binary_convert(div(n,2), "#{bit}" <> accumulator) #we obtain the binary number and, remove the last digit and adds it to the start
        end

# now we count how many bits are set to 1 in the string, through graphemes we will split it and
# iterate through everything and accumulating the count (1 will increase and 0 stays same)
defp count_ones(binary_str) do
    Enum.reduce(String.graphemes(binary_str), 0, fn char, accumulator -> if char == "1", do: accumulator + 1, else: accumulator
    end)
end

# we need to divide everything in small sections to process everything individually and recursively
# we calcualte teh start and end and add it to a list of ranges that can generate the next interval
defp create_rg(i, num_tasks, _step, _start, _n) when i >= num_tasks, do: []
defp create_rg(i, num_tasks, step, start, n) do
    start = start + i * step
    last  = min(start + (i + 1) * step - 1, n)
    if start <= last do
        [{start, last} | create_rg(i + 1, num_tasks, step, start, n)]
    else
        create_rg(i + 1, num_tasks, step, start, n)
    end
end

# to continue, we calcualte the factorial n by counting the number of 1's on their binary form, we divide
# the workand parallely multiply the numbers, then we combine the threads and use the binary function to count
# how many bits are 1 and can return the count
def factorial_one_bits(n) do
    num_tasks = 4
    step = ceil(n/num_tasks)
    ranges = create_rg(0, num_tasks, step, 1, n)
    tasks = Enum.map(ranges, fn {start, last} -> Task.async(fn -> Enum.reduce(start..last, 1, fn i, acc -> acc * i end) #(1)
    end)
end)
    factorial = Enum.map(tasks, fn t -> Task.await(t, :infinity) end) #(2)
    |> Enum.reduce(1, fn partial, acc -> acc * partial end)
    binary_string = binary(factorial)
    count_ones(binary_string)
end

#Problem 2: Prime numbers
# we will set a recusrive function that determines is the number has an odd number of divisiors by checking if the
# current divisor is exact to the number, in case it's not it means the number is not prime and the next divisor is tested
defp check_div(_x, i, limit) when i > limit, do: true
defp check_div(x, i, limit) do
    if rem(x, i)==0 do false #in case the remainder is 0
else
    check_div(x, i+2, limit)
    end
end

#determiens if the number itself is prime by setting some rules and considering special cases (numbers need to be
# bigger than 2), with that only odd divisors will be tested and will be re-sent to check-div
defp is_prime?(x) when x<2, do: false
defp is_prime?(2), do: true
defp is_prime?(x) when rem(x, 2) == 0, do: false
defp is_prime?(x) do
    limit = trunc(:math.sqrt(x)) #(3)
    check_div(x, 3, limit)
end

#sums all the prime numers, we consider numbers between 2 and n by dividing the range into the threads, we
# use this to process each one individually and check them through the previous prime fucntions that we set
# in order to add them to the sum, in case it does not apply, we ignore them, adding to the sum and keep them
# together to obtain the sum of the primes (n)
def prime_sum(n) do
    num_tasks = 4
    step = ceil((n-1)/num_tasks)
    ranges = create_rg(0, num_tasks, step, 2, n) #to create the range
    tasks = Enum.map(ranges, fn {start, last} -> Task.async(fn -> Enum.reduce(start..last, 0, fn x, accumulator -> #(1)
        if is_prime?(x), do: accumulator + x, else: accumulator
          end)
        end)
      end)
      Enum.map(tasks, fn t -> Task.await(t, :infinity) end)
      |> Enum.sum() #in here we combine the sum
    end

#Problem 3: Pi approximation
#In here we need to get as close as possible to pi through the middle, we can achieve this by using an integral
# the interval will be divided onto n rectangles, with those, we willcalcualte the half and set the value according
# to that middle part, and to add to the local sum - with that we collect all the sums and add them together
def compute_pi(n) do
    num_tasks = 4
    step = ceil(n/num_tasks)
    width = 1.0/n
    ranges = create_rg(0, num_tasks, step, 0, n-1)

    #to buidl the ranges
    tasks = Enum.map(ranges, fn {start, last} -> Task.async(fn -> Enum.reduce(start..last, 0.0, fn i, accumulator ->
        half =(i + 0.5)*width
        height = 4.0/(1.0 + half * half) #the function we are given
        accumulator + height
        end)
    end)
end)

    partial_sums = Enum.map(tasks, fn t -> Task.await(t, :infinity) end)
    |> Enum.sum()
    width * partial_sums
    end
end
