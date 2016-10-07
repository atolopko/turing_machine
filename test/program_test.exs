defmodule ProgramTest do
  use ExUnit.Case
  doctest Program

  test "add rules and find" do
    p = %{}
    p = Program.add(p, :s0, nil, [:right], :s1)
    p = Program.add(p, :s1, 1, [:left], :s2)
    p = Program.add(p, :s1, 2, [:right], :s2)
    p = Program.add(p, :s2, 3, [:erase, :right], :s3)
    assert Program.find(p, :s0, nil) == {[:right], :s1}
    assert Program.find(p, :s1, 1) == {[:left], :s2}
    assert Program.find(p, :s1, 2) == {[:right], :s2}
    assert Program.find(p, :s2, 3) == {[:erase, :right], :s3}
  end

  # test "find non-extant rule" do
  #   assert Program.find(p, :s4, 1) == nil
  # end
end
