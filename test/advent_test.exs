defmodule AdventTest do
  use ExUnit.Case
  doctest Day01_1
  doctest Day02_1

  test "day1-1" do
    assert Day01_1.run() == 357504
  end

  test "day1-2" do
    assert Day01_2.run() == 12747392
  end

  test "day2-1" do
    assert Day02_1.run() == 519
  end

  test "day2-2" do
    assert Day02_2.run() == 708
  end
end
