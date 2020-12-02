defmodule Day02_1 do
  @moduledoc """
  Improvement ideas:
  * split password rules into individual rules to increase readability
  """

  def run do
    File.stream!(Path.relative_to_cwd("inputs/day02/input.txt"))
      |> Enum.map(&splitentry/1)
      |> Enum.map(&pwdisvalid?/1)
      |> Enum.filter(&(&1))
      |> Enum.count()
  end


  def splitentry(entry) do
    # entry example:
    # 10-17 h: vpbrjcbhnwqhhphxjk
    Regex.named_captures(~r/(?<min>\d+)-(?<max>\d+) (?<letter>[a-z]): (?<pwd>.*)/, entry)
  end

  @doc """
  ## Failure
      iex> Day02_1.pwdisvalid?(%{"letter" => "q", "max" => "5", "min" => "3", "pwd" => "pjlql"})
      false

  ## Success
      iex> Day02_1.pwdisvalid?(%{"letter" => "q", "max" => "5", "min" => "3", "pwd" => "pqjqlql"})
      true
  """
  def pwdisvalid?(%{"min" => min, "max" => max, "letter" => letter, "pwd" => pwd}) do
    lettercount = String.graphemes(pwd) |> Enum.count(fn x -> x == letter end)
    min = String.to_integer(min)
    max = String.to_integer(max)
    lettercount >= min and lettercount <= max
  end

end


"""
--- Day 2: Password Philosophy ---
Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.

The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.

Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.

For example, suppose you have the following list:

1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

How many passwords are valid according to their policies?

Your puzzle answer was 12747392.
"""
