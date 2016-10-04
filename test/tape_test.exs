defmodule TapeTest do
  use ExUnit.Case
  doctest Tape

  test "initial read" do
    tape = %Tape{}
    assert Tape.read(tape) == nil
  end

  test "reads returns write" do
    tape = Tape.write(%Tape{}, 1)
    assert Tape.read(tape) == 1
  end

  def write_all(tape, list) do
    Enum.reduce(list, tape, fn(x, t) -> Tape.write(t, x) end)
  end

  test "reads returns last write" do
    tape = TapeTest.write_all(%Tape{}, [1, 2, 3])
    assert Tape.read(tape) == 3
  end

  test "move left" do
    tape = TapeTest.write_all(%Tape{}, [1, 2, 3])
    tape = Tape.move_left(tape)
    assert Tape.read(tape) == 2
  end

end
