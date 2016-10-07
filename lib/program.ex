defmodule Program do
  def add(prog, from_state, input, operations, to_state) do
    x = { operations, to_state }
    Map.update(
      prog,
      from_state,
      %{ input => x },
      fn(v) -> Map.put(v, input, x) end)
  end

  def find(prog, state, input) do
    prog[state][input]
  end
end
