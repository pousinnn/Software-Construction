# Fibonacci y factorial

def factorial(n):
    if n == 0:
        return 1
    else:
        resultado = n * factorial(n - 1)
        return resultado

def fibonacci(n):
    # casos base
    if n == 0:
        return 0
    if n == 1:
        return 1
    a = fibonacci(n - 1)
    b = fibonacci(n - 2)
    return a + b

# prueba
x = 5
y = 10
z = 3.14

fact_x = factorial(x)
fib_y = fibonacci(y)

suma = fact_x + fib_y
resta = fact_x - fib_y
multi = x * y
divi = z / x

numeros = [1, 2, 3, 4, 5]
letras = [6, 7, 8, 9, 10]

for i in numeros:
    r = factorial(i)

if suma > 100:
    resultado = True
else:
    resultado = False