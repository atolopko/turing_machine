defmodule Example do
  import Program

  def run do
    prog =
      add(:initial, nil, [{:write, 1}, :right], :s1) |>
      add(:s1, nil, [{:write, 2}, :left, :left], :s2) |>
      add(:s1, 1, [:erase, :right, {:write, 1}, :right], :s2) |>
      add(:s2, nil, [:erase], :halt)
    tm = TuringMachine.execute(prog)
    IO.inspect tm.tape
  end
end

Example.run
