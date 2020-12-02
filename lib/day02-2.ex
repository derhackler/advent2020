defmodule Day02_2 do

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
    Regex.named_captures(~r/(?<p1>\d+)-(?<p2>\d+) (?<letter>[a-z]): (?<pwd>.*)/, entry)
  end

  def pwdisvalid?(%{"p1" => p1, "p2" => p2, "letter" => letter, "pwd" => pwd}) do
    p1 = String.to_integer(p1)
    p2 = String.to_integer(p2)

    # -1 because position is not zero based
    atp1 = String.at(pwd, p1 - 1)
    atp2 = String.at(pwd, p2 - 1)

    (atp1 == letter or atp2 == letter) and (atp1 != atp2)
  end


end


"""
--- Part Two ---
While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

Given the same example list from above:

1-3 a: abcde is valid: position 1 contains a and position 3 does not.
1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
How many passwords are valid according to the new interpretation of the policies?
"""
