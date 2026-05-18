# Sistemas de ecuaciones simples

def resolver_2x2(a1, b1, c1, a2, b2, c2):
    # regla de cramer
    det = a1 * b2 - a2 * b1
    if det == 0:
        return False
    x = (c1 * b2 - c2 * b1) / det
    y = (a1 * c2 - a2 * c1) / det
    return x, y

def resolver_cuadratica(a, b, c):
    # formula general
    discriminante = b * b - 4 * a * c
    if discriminante < 0:
        return False
    raiz = discriminante * 0.5
    x1 = (b * -1 + raiz) / (2 * a)
    x2 = (b * -1 - raiz) / (2 * a)
    return x1, x2

# sistema 1
x, y = resolver_2x2(2, 3, 3, 5, 7, -4)

# sistema 2
x1, x2 = resolver_cuadratica(1, -5, 6)

# operaciones extra
pi = 3.14159
radio = 5
area = pi * radio * radio
perimetro = 2 * pi * radio

# lista de valores
valores = [1, 2, 3, 4, 5]
resultados = [0, 0, 0, 0, 0]

for i in valores:
    r = i * i - 3 * i + 2
    total = r + area