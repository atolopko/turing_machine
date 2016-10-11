# Note: TurningMachineTest is not to be confused with TuringTest! ;-)
defmodule TuringMachineTest do
  use ExUnit.Case
  doctest TuringMachine

  test "execute simple program" do
    p =
      Program.add(:initial, nil, [{:write, 1}, :right], :s1) |>
      Program.add(:s1, nil, [], :halt)
    IO.inspect p
    tm = TuringMachine.execute(p)
    assert tm.state == :halt
    assert inspect(tm.tape) == "[... 1 <nil> ...]"
  end

  test "execute write op" do
    p = Program.add(:initial, nil, [{:write, 1}], :halt)
    tape = TuringMachine.execute(p).tape
    assert Tape.read(tape) == 1
  end

  test "execute erase op" do
    tape = Tape.write(%Tape{}, 1)
    p = Program.add(:initial, nil, [:erase], :halt)
    tape = TuringMachine.execute(p).tape
    assert Tape.read(tape) == nil
  end

  test "execute left op" do
    tape =
      Tape.write(%Tape{}, 1) |>
      Tape.move_right |>
      Tape.write(2)
    p = Program.add(:initial, 2, [:left], :halt)
    tape = TuringMachine.execute(%TuringMachine{ tape: tape }, p).tape
    assert Tape.read(tape) == 1
  end

  test "execute right op" do
    tape =
      Tape.write(%Tape{}, 1) |>
      Tape.move_left |>
      Tape.write(2)
    p = Program.add(:initial, 2, [:right], :halt)
    tape = TuringMachine.execute(%TuringMachine{ tape: tape }, p).tape
    assert Tape.read(tape) == 1
  end

  test "execute multiple ops sequence" do
    p = Program.add(
      :initial,
      nil,
      [{ :write, 1 },
       :left,
       { :write, 2 },
       :right],
      :halt)
    tape = TuringMachine.execute(p).tape
    assert inspect(tape) == "[... 2 <1> ...]"
  end

  test "execute multi-state program" do
    p =
      Program.add(:initial, nil, [{:write, 1}, :right], :s1) |>
      Program.add(:s1, nil, [{:write, 2}, :left], :s1) |>
      Program.add(:s1, 1, [], :halt)
    tm = TuringMachine.execute(p)
    assert tm.state == :halt
  end

  test "execute invalid program" do
    p = Program.add(:s1, 1, [:left], :halt)
    assert_raise ProgramError, fn ->
      TuringMachine.execute(p)
    end
  end
end
