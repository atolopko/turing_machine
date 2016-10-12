defmodule Example do
  import Program

  def run do
    prog =
      add(:b, nil, [{:write, "e"}, :right,
                    {:write, "e"}, :right,
                    {:write, 0}, :right, :right,
                    {:write, 0}, :left, :left], :o) |>
      add(:o, 1, [:right, {:write, "x"}, :left, :left, :left], :o) |>
      add(:o, 0, [], :q) |>
      add(:q, :any_symbol, [:right, :right], :q) |>
      add(:q, nil, [{:write, 1}, :left], :p) |>
      add(:p, "x", [:erase, :right], :q) |>
      add(:p, "e", [:right], :f) |>
      add(:p, nil, [:left, :left], :p) |>
      add(:f, :any_symbol, [:right, :right], :f) |>
      add(:f, nil, [{:write, 0}, :left, :left], :o)
    tm = %TuringMachine{ state: :b }
    tm = TuringMachine.execute(tm, prog)
    IO.inspect tm.tape
  end
end

Example.run
