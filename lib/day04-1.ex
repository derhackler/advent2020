defmodule Day04_1 do

  @allfields ~w(byr iyr eyr hgt hcl ecl pid cid)

  def run do
    File.stream!(Path.relative_to_cwd("inputs/day04/input.txt"))
      |> Stream.map(&String.trim/1)
      |> Stream.chunk_while("",&chunkfun/2, fn acc -> {:cont, acc,""} end )
      |> Stream.map(&getfields/1)
      |> Stream.filter(&isvalid?/1)
      |> Enum.count()
  end

  def chunkfun("",acc), do: {:cont, acc, ""} # close the chunk
  def chunkfun(element,""), do: {:cont, element} # append (it's the first line --> no whitspace)
  def chunkfun(element,acc), do: {:cont, acc <> " " <> element} # append a middle segment

  def getfields(passport) do
    # expects: eyr:2029 byr:1931 hcl:z cid:128 ecl:amb hgt:150cm iyr:2015 pid:14871470
    re = ~r/([a-zA-Z]{3}):.*(\s|$)/iU
    Regex.scan(re,passport)
    |> Enum.map(fn [_all, id, _end] -> id end)
  end

  def isvalid?(fields) do
    diff = @allfields -- fields
    case diff do
      []      -> true
      ["cid"] -> true
      _       -> false
    end
  end
end
