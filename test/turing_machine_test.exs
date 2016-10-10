# Note: TurningMachineTest is not to be confused with TuringTest! ;-)
defmodule TuringMachineTest do
  use ExUnit.Case
  doctest TuringMachine

  test "execute write op" do
    tape = TuringMachine.execute_ops([{ :write, 1 }], %Tape{})
    assert Tape.read(tape) == 1
  end

  test "execute erase op" do
    tape = Tape.write(%Tape{}, 1)
    tape = TuringMachine.execute_ops([:erase], tape)
    assert Tape.read(tape) == nil
  end

  test "execute left op" do
    tape = Tape.write(%Tape{}, 1) |> Tape.move_right |> Tape.write(2)
    tape = TuringMachine.execute_ops([:left], tape)
    assert Tape.read(tape) == 1
  end

  test "execute right op" do
    tape = Tape.write(%Tape{}, 1) |> Tape.move_left |> Tape.write(2)
    tape = TuringMachine.execute_ops([:right], tape)
    assert Tape.read(tape) == 1
  end

  test "execute ops sequence" do
    tape =
      TuringMachine.execute_ops(
        [{ :write, 1 },
         :left,
         { :write, 2 },
         :right],
        %Tape{})
    IO.inspect tape
    assert Tape.read(tape) == 1
    tape = Tape.move_left(tape)
    assert Tape.read(tape) == 2
  end

  test "execute simple program" do
    p = Program.add(:initial, nil, [{:write, 1}, :right], :s1) |>
      Program.add(:s1, nil, [], :halt)
    IO.inspect p
    tm = TuringMachine.execute(p)
    assert tm.state == :halt
  end

  test "execute multi-step program" do
    p = Program.add(:initial, nil, [{:write, 1}, :right], :s1) |>
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
