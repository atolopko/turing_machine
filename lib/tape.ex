defmodule Tape do
  defstruct left: [], right: []

  def read(tape) do
    List.first(tape.left)
  end

  def write(%Tape{ left: [], right: right }, elem) do
    %Tape{ left: [elem], right: right }
  end

  def write(tape, elem) do
    %{tape | left: List.replace_at(tape.left, 0, elem)}
  end

  def move_left(%Tape{ left: [], right: right }) do
    %Tape{right: [nil | right]}
  end

  def move_left(tape) do
    [elem | rest] = tape.left
    %Tape{ left: rest,
           right: [elem | tape.right] }
  end

  def move_right(%Tape{ left: left, right: [] }) do
    %Tape{left: [nil | left]}
  end

  def move_right(tape) do
    [elem | rest] = tape.right
    %Tape{ left: [elem | tape.left],
           right: rest }
  end
end
