defmodule ProgramTest do
  use ExUnit.Case
  doctest Program

  test "add initial rule" do
    p = Program.add(:initial, nil, [:right], :s1)
    assert Program.find(p, :initial, nil) == {[:right], :s1}
  end

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

  test "execute program with ummatched program state" do
    p = Program.add(:initial, nil, [], :halt)
    assert_raise ProgramError, "undefined state :missing", fn ->
      Program.find(p, :missing, nil)
    end
  end

  test "execute program with ummatched program input" do
    p = Program.add(:s0, 1, [:right], :halt)
    assert_raise ProgramError, "undefined input 2 for state :s0", fn ->
      Program.find(p, :s0, 2)
    end
  end
end

