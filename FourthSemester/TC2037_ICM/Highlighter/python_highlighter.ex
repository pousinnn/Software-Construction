#E2 Syntax highlighter with parallel processing
#Paulina Cortez Balvanera
#A01782041
#June 11, 2026

defmodule PythonHighlighter do

  #my reserved words
  @keywords ["False", "None", "True", "case", "as", "assert",
             "async", "and", "await", "break", "class", "continue",
             "def", "del", "elif", "else", "except", "finally",
             "for", "from", "global", "if", "import", "in",
             "is", "lambda", "nonlocal", "not", "or", "pass",
             "raise", "return", "try", "while", "with", "match", "yield"]

  #my dfa and transition table for each categpry
  # each row will represent a state and the column a type of character
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
  def obtain_state(state, col) do
    if state < 13 do
      row = Enum.at(@tabla, state)
      Enum.at(row, col)
    else
      19
    end
  end

  #maps according to the corresponding part at the dfa table
  def classify(char, state) do
    letters = String.graphemes("abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ")
    digits = String.graphemes("0123456789")
    operators = String.graphemes("+-*/%=<>!&|^")
    delimiters = String.graphemes(":()[]{},;.")
    exponent = String.graphemes("eE")

    #all valid characters (dfa) and how they connect to the dfa table
    cond do
      state == 1 and char == "\"" -> 8
      state == 1 and char == "'"  -> 9
      state == 1 -> 5
      char == " " or char == "\t" -> 0
      char == "-" -> 1
      char == "+" -> 2
      Enum.member?(operators, char) -> 3
      char == "#" -> 4
      Enum.member?(exponent, char) and (state == 2 or state == 7) -> 12
      Enum.member?(letters, char) -> 5
      char == "_" -> 6
      Enum.member?(delimiters, char) -> 7
      char == "\"" -> 8
      char == "'" -> 9
      Enum.member?(digits, char) -> 10
      true -> 15
    end
  end

  #determine if we will return the next character
  defp next_char([char | _]), do: char

  #assigns the html tag depending on the acceptance state
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

  #recursive for processing one character at the moment
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
    #determine the next state
    col = classify(char, state)
    new_state = obtain_state(state, col)
      cond do #we use a cond to detetrmine if the state was reached and reworks with the character
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

  #for the multiline and 3 quotes strings
  defp read_multiline_triple([], _quote, accum) do
    {"<span class=\"string\">" <> accum <> "</span>", []}
  end

  #until the closing is encountered
  defp read_multiline_triple([line | rest], quote, accum) do
    close = quote <> quote <> quote
    if String.contains?(line, close) do
      [before, after_close] = String.split(line, close, parts: 2)
      full_string = accum <> before <> close
      html_token  = "<span class=\"string\">" <> full_string <> "</span>"
      {html_token, [after_close | rest]}
    else
      read_multiline_triple(rest, quote, accum <> line <> "\n")
    end
  end

  #process the file line by line and detect multlines
  def process_lin([], html_accum), do: html_accum
  def process_lin([line | rest], html_accum) do
    cond do #check again
      String.contains?(line, "\"\"\"") ->
        [before, after_open] = String.split(line, "\"\"\"", parts: 2)
        before_html = if before != "" do
          process_characters(String.graphemes(before <> " "), 0, "", "")
        else
          ""
        end
        {string_html, remaining} = read_multiline_triple([after_open | rest], "\"", "\"\"\"")
        process_lin(remaining, html_accum <> before_html <> string_html <> "\n")

      String.contains?(line, "'''") ->
        [before, after_open] = String.split(line, "'''", parts: 2)
        before_html = if before != "" do
          process_characters(String.graphemes(before <> " "), 0, "", "")
        else
          ""
        end
        {string_html, remaining} = read_multiline_triple([after_open | rest], "'", "'''")
        process_lin(remaining, html_accum <> before_html <> string_html <> "\n")

      line == "" ->
        process_lin(rest, html_accum <> "\n")

      true ->
        characters = String.graphemes(line <> " ")
        html_line  = process_characters(characters, 0, "", "")
        process_lin(rest, html_accum <> html_line <> "\n")
    end
  end

  #read the python fle and apply the highlighter values
  def process_file(input_path, output_path) do
    lines = input_path
      |> File.stream!()
      |> Enum.map(fn line -> String.replace(line, "\n", "") end)

    html = process_lin(lines, "")
    web = File.read!("display.html") #generate html files (x10)
    html_final = String.replace(web, "{{result}}", html)
    File.write!(output_path, html_final)
  end

  def highlight_parallel(input_dir, output_dir) do
    File.mkdir_p!(output_dir)

    files = input_dir
      |> File.ls!()
      |> Enum.filter(fn f -> String.ends_with?(f, ".py") end)

    #waiting for tasks to finish
    tasks = Enum.map(files, fn filename ->
      Task.async(fn ->
        input_path = Path.join(input_dir, filename)
        output_name = String.replace(filename, ".py", ".html")
        output_path = Path.join(output_dir, output_name)
        process_file(input_path, output_path)
      end)
    end)

    Enum.each(tasks, fn task -> Task.await(task, :infinity) end)

    IO.puts("Files were processed")
  end

  #measure the execution time
  def measure_time(function, parameters) do
    {time, _result} = :timer.tc(function, parameters)
    time / 1_000_000
  end

  #execute the highlighter and shows the total tilme
  def run(input_dir, output_dir) do
    seconds = measure_time(&highlight_parallel/2, [input_dir, output_dir])
    IO.puts("Total time: #{seconds} seconds")
  end

  # main wil read and process to output to wite the html
  def lexer_categ(file) do
    lines = file
      |> File.stream!()
      |> Enum.map(fn line -> String.replace(line, "\n", "") end)

    html = process_lin(lines, "")
    #we create the html file and insert it into a new one
    web = File.read!("display.html")
    html_final = String.replace(web, "{{result}}", html)
    File.write!("resultado.html", html_final)

    IO.puts("html file has been created")
  end

end
