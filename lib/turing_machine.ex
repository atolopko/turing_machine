defmodule TuringMachine do
  defstruct state: :initial, tape: %Tape{}

  def execute(program) do
    TuringMachine.execute(
      %TuringMachine{},
      program)
  end

  def execute(%{ state: :halt, tape: tape}, program) do
    %TuringMachine{ state: :halt, tape: tape }
  end

  def execute(tm, program) do
    { operations, to_state } =
      Program.find(program, tm.state, Tape.read(tm.tape))
    tape = execute_ops(operations, tm.tape)
    tm = %TuringMachine{ state: to_state, tape: tape }
    execute(tm, program)
  end

  def execute_ops([], tape) do
    IO.inspect tape
    tape
  end

  def execute_ops([:left | operations], tape) do
    IO.inspect tape
    execute_ops(operations, Tape.move_left(tape))
  end

  def execute_ops([:right | operations], tape) do
    IO.inspect tape
    execute_ops(operations, Tape.move_right(tape))
  end
  
  def execute_ops([:erase | operations], tape) do
    IO.inspect tape
    execute_ops(operations, Tape.erase(tape))
  end
  
  def execute_ops([{ :write, symbol } | operations], tape) do
    IO.inspect tape
    execute_ops(operations, Tape.write(tape, symbol))
  end
end
