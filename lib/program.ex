defmodule Program do
  import Map
  
  def add(prog \\ %{}, from_state, input, operations, to_state) do
    x = { operations, to_state }
    update(
      prog,
      from_state,
      %{ input => x },
      fn(v) -> put(v, input, x) end)
  end

  def find(prog, state, input) do
    unless has_key?(prog, state),
      do: raise(ProgramError, "undefined state #{inspect state}")

    input = if input != nil && has_key?(prog[state], :any_symbol) do
      :any_symbol
    else
      input
    end
      
    unless has_key?(prog[state], input),
      do: raise(ProgramError, "undefined input #{inspect input} for state #{inspect state}") 

    prog[state][input]
  end
end

defmodule ProgramError do
  defexception message: "program error"
end
