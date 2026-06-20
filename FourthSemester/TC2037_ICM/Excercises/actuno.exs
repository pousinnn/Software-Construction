#problem 1: fahrenheit to celsius
defmodule Hw.Ariel1 do
    def fahrenheit_to_celsius(f) do
        5*(f-32)/9
    end

#problem 2: roots for quadrratic coefficents
def roots(a,b,c) do
  (-b+ :math.sqrt(b*b - 4*a*c))/(2*a)
end

#problem 3: integer (negative and positive)
def sign(n) do
  cond do
    n<0 -> -1
    n> 0 -> 1
    n==0 -> 0
  end
end

#problem 4: body mass
def bmi(weight,height) do bmi= weight/(height*height)
cond do
  bmi<20 -> :underweight
  bmi>=20 and bmi<25 -> :normal
  bmi>=25 and bmi<30 -> :obese1
  bmi>=30 and bmi<40 -> :obese2
  bmi>=40 -> :obese3
end
end

#problem 5: factorial
def factorial(n) do
cond do n==0 -> 1
n>0 -> n*factorial(n-1)
end
end

#problem 6: cosito pow elevado
def pow(base, exp) do
  cond do exp==0 -> 1
    exp>0 -> base*pow(base,exp - 1)
  end
end

#problem 7: fibonacci
def fib(n) do
  cond do n==0 -> 0
  n==1 -> 1
  n>1 -> fib(n-1)+fib(n-2)
end
end

#problem 8: duplicate con lista
def duplicate([]) do []
end
def duplicate([head|tail]) do [head,head|duplicate(tail)]
end

#problemm 9: enlist inside sublist
def enlist([]) do []
end
def enlist([head|tail]) do [[head]|enlist(tail)]
end

#problem 10: lista the numeros a positivos
def positives([]) do []
end
def positives([head|tail]) do
  cond do
    head>0 -> [head|positives(tail)]
    true->positives(tail)
  end
end

#problem 11
def add_list([]) do 0
end
def add_list([head|tail]) do head+add_list(tail)
end

#problem 12: lista de tuples y se invierten
def invert_pairs([]) do []
end
def invert_pairs([{a,b}|tail]) do [{b,a}]++ invert_pairs(tail)
end

#problem 13: symbol o atom
def is_atom_list([]) do true
end
def is_atom_list([head|tail]) do
  cond do is_atom(head) -> is_atom_list(tail)
    true -> false
  end
end

#problem 14: Swapper
def swapper(list,a,b) do
  cond do list==[] -> []
  hd(list)==a -> [b]++ swapper(tl(list),a,b)
  hd(list)==b -> [a]++ swapper(tl(list),a,b)
  true -> [hd(list)]++ swapper(tl(list),a,b)
end
end

#problem 15: dot product de dos listas
def dot_product(listuno,listdos) do
  cond do listuno==[] -> 0
  true -> hd(listuno)*hd(listdos)+dot_product(tl(listuno),tl(listdos))
end
end

#problem 16: average con mean
def average(list) do
  cond do list==[] -> 0
  true -> {suma,count} = average_m(list,0,0)
  suma/count
end
end
def average_m(list,suma,count) do
  cond do list==[] -> {suma,count}
  true -> average_m(tl(list),suma + hd(list), count+1)
end
end

#problem 17: standard deviation
def std_dev([]) do
  0
end
def std_dev(list) do
  avge=average(list)
  :math.sqrt(suma_d(list,avge)/length(list))
end
def suma_d([], _) do 0
end
def suma_d([head|tail],avge) do (head-avge)*(head-avge)+suma_d(tail,avge)
end

#problem 18: reeplicating elements
def replic(n,list) do
  cond do list==[] -> []
  n==0 -> []
  true -> replica(hd(list),n)++ replic(n,tl(list))
end
end
def replica(valor,n) do
  cond do n==0 -> []
  true -> [valor]++ replica(valor,n-1)
  end
end

#problem 19: expandir listap
def expand(list) do expand(list, 1)
end
def expand([],_) do []
end
def expand([head|tail],n) do repeat(head,n) ++ expand(tail,n+1)
end
def repeat(_,0) do []
end
def repeat(value,n) do [value] ++ repeat(value,n-1)
end

#problem 20
def binary(n) do
  cond do n==0 -> []
  true -> binary(div(n,2))++[rem(n,2)]
end
end

#---------------------
end
