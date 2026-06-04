# Activity 5.2 Parallel and concurrent programming  
**Paulina Cortez Balvanera | A01782041**

*June 03, 2026*

For this work there were three main excercises: 
1. A factorial calculation (Ex.1)
2. Prime number summation (Ex.2)
3. Numerical approximation of pi (Ex.3)

There is a total of four alterantives for each excercise:
1. Sequential version in Elixir
2. Parallel version in Elixir
3. Sequential version in .C
4. Parallel version in .C

## Execution instructions
### Elixir
For the Elixir files we are required to enter the terminal and enter the next commands:

| Version | Command | 
|----------|--------|
| Sequential | `iex Activity5_2_Sequential.ex` |
| Parallel | `iex Activity5_2_Parallel.ex` | 

After opening this commands, the interactive elixir section will be available, to check the results we can call the functions; 

| Function | Sequential | Parallel |
|----------|------------|----------|
| Ex.1: factorial | Sequential.factorial_one_bits(10) | Parallel.factorial_one_bits(10) |
| Ex.2: Primes | Sequential.prime_sum(100) | Parallel.prime_sum(100) |
| Ex.3: Pi | Sequential.compute_pi(1000000) | Parallel.compute_pi(1000000) |

*Note: For the first and second excercise, the numbers work as examples - all the number combinations should be possible*  

On the other side, to run the .c programs we will require to run the next commands in the terminal:

| Version | Command |
|----------|--------|
| Sequential | `gcc Activity5_2_Sequential.c -o sequential -lm` |
| Parallel | `gcc Activity5_2_Parallel.c -o parallel -lm -pthread` |

This commands will allow the program to compile, to run we will need to write: 

| Version | Command | Example |
|----------|--------|----------|
| Sequential | `./sequential <n>` | `./sequential 10` |
| Parallel | `./parallel <n>` | `./parallel 10` |

## Process
In my case, to parallelize the program, i decided to take the original sequential solutions and split their workload into smaller independent parts (threads) that could be executed at the same time using threads. For each exercise, the input range was meant to be divided among the threads, and each of those threads were responsible for working together to develop partial result within its segment. In the factorial and prime sum exercises, each thread calculated a partial product or sum, in the case of the the pi approximation each thread computed a portion of the  sum that could be done with the big integral. After all those threads finished their execution, the partial results were combined into a final result using shared variables with mutexes to avoidwrong stuff. I think that this approach allowed the whole program to perform the different and various computations concurrently while maintaining correctness and proper results, and it also made it possible to compare the execution time between the sequential and parallel versions to observe the performance improvement.

### References of extra stuff i had to search to understand the homework (can be seen in code)

1) [https://hexdocs.pm/elixir/1.12/Range.html](https://hexdocs.pm/elixir/1.12/Range.html)  
   [https://hexdocs.pm/elixir/Range.html](https://hexdocs.pm/elixir/Range.html)  
2) [https://elixir.hexdocs.pm/1.12/Inspect.Opts.html](https://elixir.hexdocs.pm/1.12/Inspect.Opts.html)  
   [https://elixirforum.com/t/is-there-a-way-to-represent-infinity-in-erlang-elixir/27114](https://elixirforum.com/t/is-there-a-way-to-represent-infinity-in-erlang-elixir/27114)  
3) [https://til.hashrocket.com/posts/dqxvqo9oef-truncating-floats-in-elixir](https://til.hashrocket.com/posts/dqxvqo9oef-truncating-floats-in-elixir)  
   [https://hexdocs.pm/elixir/1.12/Float.html](https://hexdocs.pm/elixir/1.12/Float.html)   
4) [https://www.ibm.com/docs/es/i/7.5.0?topic=files-mathh](https://www.ibm.com/docs/es/i/7.5.0?topic=files-mathh)  
   [https://www.w3schools.com/c/c\_ref\_math.php](https://www.w3schools.com/c/c_ref_math.php)   
   