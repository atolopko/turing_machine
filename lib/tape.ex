#require IEx;

defmodule Tape do
  defstruct left: [], right: []

  def read(tape) do
    List.first(tape.left)
  end

  def write(tape, elem) do
    %{tape | left: [elem | tape.left]}
  end

  def move_left(tape) do
    [elem | rest] = tape.left
    tape = %{tape | right: rest}
    %{tape | left: [elem | tape.left]}
  end

  def move_right(tape) do
    [elem | rest] = tape.right
    tape = %{tape | left: rest}
    %{tape | right: [elem | tape.right]}
  end
end
