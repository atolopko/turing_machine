defmodule Program do
  def add(prog \\ %{}, from_state, input, operations, to_state) do
    x = { operations, to_state }
    Map.update(
      prog,
      from_state,
      %{ input => x },
      fn(v) -> Map.put(v, input, x) end)
  end

  def find(prog, state, input) do
    unless Map.has_key?(prog, state),
      do: raise(ProgramError, "undefined state #{inspect state}") 
    unless Map.has_key?(prog[state], input),
      do: raise(ProgramError, "undefined input #{inspect input} for state #{inspect state}") 
    prog[state][input]
  end
end

defmodule ProgramError do
  defexception message: "program error"
end
