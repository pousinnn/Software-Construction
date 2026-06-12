#Python highlighter
#E1 Syntax highlighter
#Paulina Cortez Balvanera
#A01782041
#May 15, 2026


defmodule PythonHighlighter do

  @keywords ["False", "None", "True", "case", "as", "assert",
             "async", "and", "await", "break", "class", "continue",
             "def", "del", "elif", "else", "except", "finally",
             "for", "from", "global", "if", "import", "in",
             "is", "lambda", "nonlocal", "not", "or", "pass",
             "raise", "return", "try", "while", "with", "match", "yield"]

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

  def obtain_state(state, col) do
    if state < 13 do
      row = Enum.at(@tabla, state)
      Enum.at(row, col)
    else
      19
    end
  end

  def classify(char, state) do
    letters = String.graphemes("abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ")
    digits = String.graphemes("0123456789")
    operators = String.graphemes("+-*/%=<>!&|^")
    delimitors = String.graphemes(":()[]{},;.")
    exponent = String.graphemes("eE")

    cond do
      state == 1 and char == "\"" -> 8
      state == 1 and char == "'"  -> 9
      state == 1               -> 5

      char == " " or char == "\t" -> 0
      char == "-" -> 1
      char == "+" -> 2
      Enum.member?(operators, char) -> 3
      char == "#" -> 4
      Enum.member?(exponent, char) and (state == 2 or state == 7) -> 12
      Enum.member?(letters, char) -> 5
      char == "_" -> 6
      Enum.member?(delimitors, char) -> 7
      char == "\"" -> 8
      char == "'" -> 9
      Enum.member?(digits, char) -> 10
      true -> 15
    end
  end

  defp next_char([char | _]), do: char

  def to_html(state, lexer, next \\ "") do
    cond do
      state == 13 ->
        "<span class=\"number\">" <> lexer <> "</span>"
      state == 14 ->
        "<span class=\"operator\">" <> lexer <> "</span>"
      state == 15 ->
        "<span class=\"comment\">" <> lexer <> "</span>"
      state == 16 or state == 17 ->
        if lexer in @keywords do
          "<span class=\"keyword\">" <> lexer <> "</span>"
        else
          if next == "(" do
            "<span class=\"function\">" <> lexer <> "</span>"
          else
            "<span class=\"identifier\">" <> lexer <> "</span>"
          end
        end
      state == 18 ->
        "<span class=\"delimiter\">" <> lexer <> "</span>"
      state == 19 ->
        "<span class=\"error\">" <> lexer <> "</span>"
      true -> ""
    end
  end

  defp triple_quote?([char1, char2, char | _], quote_char),
  do: char1 == quote_char and char2 == quote_char and char == quote_char

  defp triple_quote?(_, _),
  do: false

  defp read_triple([char1, char2, char | rest], quote_char, accum) do
    if char1 == quote_char and char2 == quote_char and char == quote_char do {accum <> quote_char <> quote_char <> quote_char, rest}
  else
    read_triple([char2, char | rest], quote_char, accum <> char1)
  end
end

  defp read_triple([char1], _quote_char, accum) do
    {accum <> char1, []}
  end

  defp read_triple([char1, char2], _quote_char, accum) do
    {accum <> char1 <> char2, []}
  end

  defp read_triple([], _quote_char, accum) do
    {accum, []}
  end

  def process_characters([], state, lexer, html_accum) do
    if lexer != "" do
      if state == 10 do
        html_accum <> "<span class=\"comment\">" <> lexer <> "</span>"
      else
        html_accum <> to_html(state, lexer)
      end
    else
      html_accum
    end
  end

  def process_characters([char | rest], state, lexer, html_accum) do
    if state == 0 and (char == "\"" or char == "'") and triple_quote?([char | rest], char) do
      [_q_char1, _q_char2 | after_open] = rest
      {content, remaining} = read_triple(after_open, char, "")
      html_token = "<span class=\"string\">" <> char <> char <> char <> content <> "</span>"
      process_characters(remaining, 0, "", html_accum <> html_token)
    else
      col = classify(char, state)
      new_state = obtain_state(state, col)

      cond do
        new_state >= 13 ->
          if lexer != "" do
            if state == 1 do
              html_token = "<span class=\"string\">" <> lexer <> char <> "</span>"
              process_characters(rest, 0, "", html_accum <> html_token)
            else
              html_token = to_html(new_state, lexer, next_char([char | rest]))
              process_characters([char | rest], 0, "", html_accum <> html_token)
            end
          else
            html_token = to_html(new_state, char)
            process_characters(rest, 0, "", html_accum <> html_token)
          end

        new_state == 0 ->
          html_token = if lexer != "", do: to_html(state, lexer), else: ""
          process_characters(rest, 0, "", html_accum <> html_token <> char)

        new_state == 1 ->
          process_characters(rest, 1, lexer <> char, html_accum)

        true ->
          process_characters(rest, new_state, lexer <> char, html_accum)
      end
    end
  end

  def process_lin([], html_accum) do
    html_accum
  end

  def process_lin([line | rest], html_accum) do
    characters = String.graphemes(line <> " ")
    html_line = process_characters(characters, 0, "", "")
    process_lin(rest, html_accum <> html_line <> "\n")
  end

  def lexer_categ(file) do
    lines = File.stream!(file)
      |> Enum.map(fn line -> String.replace(line, "\n", "") end)

    html = process_lin(lines, "")

    web = File.read!("display.html")
    html_final = String.replace(web, "{{result}}", html)
    File.write!("resultado.html", html_final)

    IO.puts("html file has been created")
  end
end
