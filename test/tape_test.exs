defmodule TapeTest do
  use ExUnit.Case
  doctest Tape

  test "inspect with empty left and right" do
    t = %Tape{ left: [],
               right: [] }
    assert(inspect(t) == "[... <nil> ...]")
  end

  test "inspect with non-empty left and right" do
    t = %Tape{ left: [2, 1],
               right: [3, 4] }
    assert(inspect(t) == "[... 1 <2> 3 4 ...]")
  end

  test "inspect with empty left" do
    t = %Tape{ left: [],
               right: [3, 4] }
    assert(inspect(t) == "[... <nil> 3 4 ...]")
  end

  test "inspect with empty right" do
    t = %Tape{ left: [2, 1],
               right: [] }
    assert(inspect(t) == "[... 1 <2> ...]")
  end

  test "initial read" do
    tape = %Tape{}
    assert Tape.read(tape) == nil
  end

  test "initial write" do
    tape = Tape.write(%Tape{}, 1)
    assert Tape.read(tape) == 1
  end

  test "write overwrites current position" do
    tape = %Tape{ left: [1, 2] }
    assert Tape.write(tape, 3) == %Tape{ left: [3, 2] }
  end

  test "read returns last write" do
    tape = Tape.write(%Tape{}, 1) |> Tape.write(2)
    assert Tape.read(tape) == 2
  end

  test "erase" do
    tape = Tape.write(%Tape{}, 1) |> Tape.erase
    assert Tape.read(tape) == nil
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
