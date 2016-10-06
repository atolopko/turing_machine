defmodule TapeTest do
  use ExUnit.Case
  doctest Tape

  test "initial read" do
    tape = %Tape{}
    assert Tape.read(tape) == nil
  end

  test "read returns write" do
    tape = Tape.write(%Tape{}, 1)
    assert Tape.read(tape) == 1
  end

  test "write overwrites current position" do
    tape = %Tape{ left: [1, 2] }
    assert Tape.write(tape, 3) == %Tape{ left: [3, 2] }
  end

  test "read returns last write" do
    tape = %Tape{ left: [1, 2, 3] }
    assert Tape.read(tape) == 1
  end

  test "move left when at left end" do
    t = Tape.move_left(%Tape{})
    assert t == %Tape{left: [], right: [nil]}
  end

  test "move right when at right end" do
    t = Tape.move_right(%Tape{})
    assert t == %Tape{left: [nil], left: [nil]}
  end

  test "move left" do
    tape = %Tape{ left: [1, 2, 3, 4] }
    tape = Tape.move_left(tape)
    assert Tape.read(tape) == 2
  end

  test "move right" do
    tape = %Tape{ right: [1, 2, 3, 4] }
    tape = Tape.move_right(tape)
    assert Tape.read(tape) == 1
  end

  test "move left and right" do
    tape = %Tape{ left: [1, 2, 3, 4] }
    tape = Tape.move_left(tape)
    assert Tape.read(tape) == 2
    tape = Tape.move_left(tape)
    assert Tape.read(tape) == 3
    tape = Tape.move_right(tape)
    assert Tape.read(tape) == 2
    tape = Tape.move_right(tape)
    assert Tape.read(tape) == 1
  end

end
