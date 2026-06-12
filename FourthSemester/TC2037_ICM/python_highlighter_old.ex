#E1 Syntax highlighter
#Paulina Cortez Balvanera
#A01782041
#May 15, 2026

defmodule PythonHighlighter do

  #my reserved words
  @keywords ["False", "None", "True", "case", "as", "assert",
             "async", "and", "await", "break", "class", "continue",
             "def", "del", "elif", "else", "except", "finally",
             "for", "from", "global", "if", "import", "in",
             "is", "lambda", "nonlocal", "not", "or", "pass",
             "raise", "return", "try", "while", "with", "match", "yield"]

  #my dfa and transition table for each categpry
  @tabla [
    [0, 8, 9, 9, 10, 11, 11, 12, 1, 1, 2, 6, 19, 0, 11, 19],
    [1, 1, 1, 1, 1, 1, 1, 1, 13, 13, 1, 1, 1, 1, 1, 19],
    [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 2, 6, 3, 13, 13, 19],
    [19, 4, 4, 19, 19, 19, 19, 19, 19, 19, 5, 19, 19, 19, 19, 19],
    [19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 5, 19, 19, 19, 19, 19],
    [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 5, 13, 13, 13, 13, 19],
    [19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 7, 19, 19, 19, 19, 19],
    [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 7, 13, 3, 13, 13, 19],
    [9, 19, 9, 9, 14, 14, 14, 14, 14, 14, 2, 14, 14, 14, 14, 19],
    [14, 9, 9, 9, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 19],
    [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 15, 10, 19],
    [16, 16, 16, 16, 16, 11, 11, 16, 16, 16, 11, 16, 16, 16, 17, 19],
    [18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19]
  ]

  #cycle for checking the state according to previous state and character
  def obtener_estado(estado, col) do
    if estado < 13 do
      fila = Enum.at(@tabla, estado)
      Enum.at(fila, col)
    else
      19
    end
  end

  #maps according to the corresponding part at the dfa table
  def clasificar(c, estado) do
  letras = String.graphemes("abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ")
  digitos = String.graphemes("0123456789")
  operadores = String.graphemes("+-*/%=<>!&|^")
  delimitadores = String.graphemes(":()[]{},;")
  exponente = String.graphemes("eE")


  cond do
    c == " " or c == "\t" -> 0
    c == "-" -> 1
    c == "+" -> 2
    Enum.member?(operadores, c) -> 3
    c == "#" -> 4
    Enum.member?(exponente, c) and (estado == 2 or estado == 8 or estado == 7) -> 12
    Enum.member?(letras, c) -> 5
    c == "_" -> 6
    Enum.member?(delimitadores, c) -> 7
    c == "\"" -> 8
    c == "'" -> 9
    Enum.member?(digitos, c) -> 10
    c == "." -> 11
    true -> 15
  end
end
#assigns the html tag depending on the acceptance state
  def a_html(estado, lexema) do
    cond do
      estado == 13 ->
        "<span class=\"number\">" <> lexema <> "</span>"
      estado == 14 ->
        "<span class=\"operator\">" <> lexema <> "</span>"

      estado == 15 ->
        "<span class=\"comment\">" <> lexema <> "</span>"

      estado == 16 ->
        if lexema in @keywords do
          "<span class=\"keyword\">" <> lexema <> "</span>"
        else
          "<span class=\"identifier\">" <> lexema <> "</span>"
        end

      estado == 18 ->
        "<span class=\"delimiter\">" <> lexema <> "</span>"

      estado == 19 ->
        "<span class=\"error\">" <> lexema <> "</span>"

      true -> ""
    end
  end

#base case
  def process_chars([], estado, lexema, html_acc) do
    if lexema != "" do
      if estado == 10 do
        html_acc <> "<span class=\"comment\">" <> lexema <> "</span>"
      else
        html_acc <> a_html(estado, lexema)
      end
    else
      html_acc
    end
  end

  #recursive for processing one character at the moment
  def process_chars([c | resto], estado, lexema, html_acc) do
    col = clasificar(c, estado)
    new_estado = obtener_estado(estado, col)

    cond do #we use a cond to detetrmine if the state was reached and reworks with the character
      new_estado >= 13 ->
        html_token = if lexema != "", do: a_html(new_estado, lexema), else: ""
        process_chars([c | resto], 0, "", html_acc <> html_token)

      new_estado == 0 ->
        html_token = if lexema != "", do: a_html(estado, lexema), else: ""
        process_chars(resto, 0, "", html_acc <> html_token <> c)

      true ->
        process_chars(resto, new_estado, lexema <> c, html_acc)
      end
    end

  # process every single line
  def process_lin([], html_acc) do
    html_acc
  end

  #recursive to process one line at the time
  def process_lin([linea | resto], html_acc) do
    chars = String.graphemes(linea <> " ")
    html_linea = process_chars(chars, 0, "", "")
    process_lin(resto, html_acc <> html_linea <> "\n")
  end

  # main wil read and process to output to wite the html
  def lexer_categ(archivo) do
  lineas = File.stream!(archivo)
    |> Enum.map(fn linea -> String.replace(linea, "\n", "")
  end)

  html = process_lin(lineas, "")

  #we create the html file and insert it into a new one
  web = File.read!("display.html")
  html_final = String.replace(web, "{{result}}", html)
  File.write!("resultado.html", html_final)

  IO.puts("html file has been created")
end
end
