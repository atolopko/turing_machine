defmodule TuringMachine do
  require Logger

  defstruct state: :initial, tape: %Tape{}

  def execute(program) do
    execute(
      %TuringMachine{},
      program)
  end

  def execute(%{ state: :halt, tape: tape}, _) do
    %TuringMachine{ state: :halt, tape: tape }
  end

  def execute(tm, program) do
    { operations, to_state } =
      Program.find(program, tm.state, Tape.read(tm.tape))
    tape = execute_ops(operations, tm.tape)
    tm = %TuringMachine{ state: to_state, tape: tape }
    Logger.info "state=#{tm.state} #{inspect tm.tape}"
    execute(tm, program)
  end

  defp trace(op, tape) do
    Logger.debug "#{inspect op}: #{inspect tape}"
    tape
  end

  defp execute_ops([], tape) do
    tape
  end

  defp execute_ops([:left | operations], tape) do
    trace :left, execute_ops(operations, Tape.move_left(tape))
  end

  defp execute_ops([:right | operations], tape) do
    trace :right, execute_ops(operations, Tape.move_right(tape))
  end
  
  defp execute_ops([:erase | operations], tape) do
    trace :erase, execute_ops(operations, Tape.erase(tape))
  end
  
  defp execute_ops([{:write, symbol} | operations], tape) do
    trace {:write, symbol}, execute_ops(operations, Tape.write(tape, symbol))
  end
end
