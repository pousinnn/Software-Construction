# Context-free grammars

Name: Paulina Cortez Balvanera 

Student ID: A01782041

Date: May 22nd, 2026

## Grammar definitions

Describe the basic grammar necessary to write a valid *construction* in the language indicated.

The contents of the *construction* do not need to be specified.

Consider all the requirements for the construction according to the language. For example, the rules for the names of the constructions

![alt text](<Untitled P15.png>)

## Section I: Functions in C/C++
### Code in C/C++
```C
int age(int one, int two, char three) {
    return one + two;
}
void greet(char* name, char* surname) {
    printf("Hello %s %s\n", name, surname);
}
float something(void) {
    int a = 5;
    int b = 34;
    return b / a;
}
void nothing(int solution) {
    int test = solution % 5;
    printf("%d", test);
}
int main() {
    return 0;
}
```

### BNF C / C++ functions

```xml
<function>::= <datatype><function_name> (<parameters>) {<content>}
<datatype>::= int | float | void | char
<parameters>::= <parameter>|<parameter> , <parameters>| void | 𝜆
<parameter>::= <datatype> <name>
<content>::= <statement>|<statement><content>| 𝜆
<statement> ::= <expression> | 𝜆
<function_name>::= <letter>|<letter><function_name>
<name>::= <letter>|<letter><name>
<letter>::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
```

### EBNF C / C++ functions

```bash
FUNCTION::= DATATYPE FUNCTION_NAME ( [PARAMETERS] ) {CONTENT}
DATATYPE::= int | float | void | char
PARAMETERS::= PARAMETER {, PARAMETER} | void
PARAMETER::= DATATYPE NAME
CONTENT::= { STATEMENT }
```

## Section II: Functions & Modules in Elixir
### Code in Elixir
```Elixir
defmodule Training do
    def quick, do: IO.puts("HELLO!")
    def add(a, b), do: a + b

    def factorial(0), do: 1
    def factorial(n), do: n * factorial(n - 1)

    def fibo(n) when n < 0, do: :error
    def fibo(n) when n < 2, do: n
    def fibo(n), do: fibo(n - 1) + fibo(n - 2)

    defp quadratic(a, b, c) do
      d = b ** 2 - 4 * a * c
      cond do
        a == 0 and b == 0 -> {:error, :unsolvable}
        a == 0 -> {:ok, [-c / b]}
        d < 0 -> {:error, :complex}
        true ->
          x1 = (-b + :math.sqrt(d)) / (2 * a)
          x2 = (-b - :math.sqrt(d)) / (2 * a)
          {:ok, [x1, x2]}
      end
    end

    defp default(name \\ "Pepito") do
      IO.puts("Good morning #{name}")
    end
end
```

### BNF Elixir modules

```xml
<module>::= defmodule <name_module> do <body> end
<body>::= <function> | <function> <body> | 𝜆
```

### EBNF Elixir modules

```bash
MODULE::= defmodule NAME_MODULE do { FUNCTION } end
```

### BNF Elixir functions

```xml
<function> ::= <visibility> <name_function> <arguments> <clause> do <body_function> end | <visibility> <name_function> <arguments> <clause> , do : <expression>
<visibility>::= def|defp
<arguments>::= (<parameters>) | 𝜆
<parameters>::= <parameter>|<parameter> , <parameters> | 𝜆
<body_function>::= <statement> | <statement> <body_function> | 𝜆
<parameter>::= <name_variable>|<name_variable> \\ <expression>
<expression>::= <name>|<number>|<expression> + <expression>
<clause>::= when <expression> | 𝜆

```

### EBNF Elixir functions
```bash
FUNCTION::= VISIBILITY NAME_FUNCTION [ARGUMENTS][ CLAUSE ] ( do BODY_FUNCTION end | , do : EXPRESSION )
VISIBILITY::= def|defp
ARGUMENTS::= ( [PARAMETERS] )
PARAMETERS::= PARAMETER { , PARAMETER }
PARAMETER::= NAME_VARIABLE | NAME_VARIABLE \\ EXPRESSION

```
References that helped me this activity: 

- [Empty strings](https://cs.stackexchange.com/questions/64819/what-is-the-origin-of-%CE%BB-for-empty-string)
- [Context on BNF + undesrtanding commas and symbols](https://es.wikipedia.org/wiki/Notaci%C3%B3n_de_Backus-Naur)
- [Context on EBNF](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form)
- [Class presentation](https://docs.google.com/presentation/d/17-fX88JTv4Z3xG6yVAt-jFj6Txy6rj20C5xbiMlytXk/edit?slide=id.p36#slide=id.p36)