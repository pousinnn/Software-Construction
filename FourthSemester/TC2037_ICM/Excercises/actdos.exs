#Pau Cortez Balvanera | A01782041

defmodule Hw.Ariel2 do
  #problem 1
def insert(list, element), do: do_insert(list, element, [])
# base case
defp do_insert([], element, temp) do
  Enum.reverse(temp) ++ [element]
end
# insert before head
defp do_insert([head|tail], element, temp) when element< head do
  Enum.reverse(temp) ++ [element, head|tail]
end
# recursive case
defp do_insert([head | tail], element, temp) do
  do_insert(tail, element, [head|temp])
end

#problem 2
#base case
def insertion_sort([]), do: [] #empty list
#recursive case
def insertion_sort([head|tail]) do
  insert(insertion_sort(tail), head) #takes head into correct placement
end

#problem 3:
def rotate_left([], _n), do: []
def rotate_left(lista, n), do: do_rotate_left(lista, n, length(lista)) #we rotate the list as many times to the left
defp do_rotate_left(lista,0,_len), do: lista #check if n=0 in that casw we return the list
defp do_rotate_left(lista,n,len) when n>0 do
[head|tail]=lista #takes first element and will send it to tail (reducing n)
do_rotate_left(tail ++ [head], n-1, len)
end
defp do_rotate_left(lista, n, len), do: do_rotate_left(lista, len + n, len) #checks for negatives

#problem 4:
def prime_factors(1), do: [] #case vase take into account that 1 does not have prime factors
def prime_factors(n) do
  do_f(n,2) #we start from 2
end
#base case
defp do_f(1, _factor), do: []
defp do_f(n, factor) when rem(n, factor)== 0 do #considering the remainder, we either svae the factor and continue or tries again with the next number
[factor | do_f(div(n, factor), factor)]
end
defp do_f(n, factor) do
do_f(n, factor + 1)
end

#problem 5
#base case (based on test)
def gcd(0,0), do: 0 #for both numbers being 0
def gcd(a,0), do: a #compares second number to 0
def gcd(0,b), do: b #same as above but reversed
#recursivve
def gcd(a,b) do #for numbers that are not 0
  small=if a<b, do: a, else: b #checks if a or b is smaller
  div(a, b, small) #set divisor(d) to consider both numbers and the one that does first
end
defp div(_a,_b,0), do: 1 #in case we have a 0, we will retrun 1
defp div(a,b,d) do
  if rem(a,d)==0 and rem(b,d)==0 do d
else
  div(a,b,d-1)
end
end

#problem 6
def deep_reverse([]), do: [] #will invert the list and the lists that are inside the list
def deep_reverse([head|tail]) do
  deep_reverse(tail)++[op(head)]
end
defp op(part) when is_list(part) do #checks if it is a list and will ve inverted
  deep_reverse(part)
end
defp op(part), do: part #in case it is not a list, it will stay the same

#problem 7
def insert_everywhere([], a), do: [[a]]
def insert_everywhere([head | tail], a) do #will insert it at the start
  simulan = [[a, head | tail]]
  pahinga = add_h(head, insert_everywhere(tail, a)) #will insert everything's left
  simulan ++pahinga #connects both results
end
defp add_h(_, []), do: []
defp add_h(head, [simulan | pahinga]) do
  n_lista = [head | simulan]
  [n_lista | add_h(head, pahinga)]
end

#problem 8:
def pack([]), do: [] #check if we are working with an empty list
def pack([head|tail]) do #separates and calls t_lista with the elements and the rest of the list
[gr,next]= t_lista(head, tail)
[[head|gr]|pack(next)] #will group everything in order to continue
end
defp t_lista(_,[]), do: [[],[]] #when we have no elements left
defp t_lista(a,[head|tail]) do
  if a == head do #when they are the smae
    [gr,next]=t_lista(a,tail)
    [[head|gr],next]
  else
    [[],[head|tail]] #when they are different
  end
end

#problem 9:
def compress([]), do: [] #empty list
def compress([head]), do: [head] #single element
def compress([head|tail]) do
  [next|_] = tail
  if head == next do #in case they are the same, we will ignore
    compress(tail) #will save the element
  else
    [head|compress(tail)] #
  end
end

#problem 10:
def encode([]), do: []
def encode(in_list) do
  encode_groups(pack(in_list)) #groups and counts encode_groups
end
defp encode_groups([]), do: []
defp encode_groups([current_gr|resto_gr]) do
  gr_size= tamaño(current_gr) #counts the elements
  gr_value= first_element(current_gr) #obtain value
  [{gr_size, gr_value}|encode_groups(resto_gr)]
end
defp first_element([f|_]), do: f #gives the first element
#recursive step
defp tamaño([]), do: 0
defp tamaño([_| tail]), do: 1 + tamaño(tail)

#problem 11:
def encode_modified([]), do: []
def encode_modified([head|tail]) do
  [count,next]=cuenta_cambio(head,tail,1) #how many time head appears
  if count == 1 do
    [head| encode_modified(next)]
  else
    [{count, head}|encode_modified(next)]
  end
end
defp cuenta_cambio(a, [], count), do: [count, []] #the list is finished
defp cuenta_cambio(a,[head|tail],count) do
  if a== head do
    cuenta_cambio(a, tail,count+1)
  else
    [count,[head|tail]] #the changes are completed and gives the result back
  end
end

#problem 12:
def decode([]), do: []
def decode([{count,value}|tail]) do
  again(value,count)++decode(tail) #repeats the value (n) times and will unify them
end
def decode([head|tail]) do
  [head|decode(tail)]
end
defp again(_value,0), do: [] #repeats process
defp again(value,n) do
  [value|again(value,n-1)]
end

#problem 13:
#note: arity refers to the number of parameters a function will accept
def aplicar(f,x,y) do
  f.(y,x) #will call the function '.'
end
def args_swap(f) do
  &aplicar(f, &1, &2) #with inverted arguements and uses anonimous functions to solve
end

#problem 14:
def there_exists_one?(guess, lst) do
  contador=for_true(guess, lst)
  if contador==1 do
    true
  else
    false
  end
end
defp for_true(_guess, []), do: 0
defp for_true(guess, [head|tail]) do
  if guess.(head) do
    1+for_true(guess,tail)
  else
    for_true(guess,tail)
  end
end

#problem 15:
def linear_search(lst, x, eq_fun) do
  search(lst, x, eq_fun, 0)
end
#base case: takes into account when the list is empty
defp search([],_x, _eq_fun, _ind), do:
false
defp search([head|tail], x, eq_fun, ind) do
  if eq_fun.(head, x) do ind
else
  search(tail, x, eq_fun, ind+1)
end
end

#___________________
end
