defmodule Day04_2 do
  @doc """
  To be improved:
  * chunking is hard to read
  """
  @allfields ~w(byr iyr eyr hgt hcl ecl pid cid)

  def run do
    File.stream!(Path.relative_to_cwd("inputs/day04/input.txt"))
      |> Stream.map(&String.trim/1)
      |> Stream.chunk_while("",&chunkfun/2, fn acc -> {:cont, acc,""} end )
      |> Stream.map(&getfields/1) # --> [[{"fld",val},..],[..]]
      |> Stream.map(&valid_fields/1)
      |> Stream.filter(&required_fields_present?/1)
      |> Enum.count()
  end

  def chunkfun("",acc), do: {:cont, acc, ""} # close the chunk
  def chunkfun(element,""), do: {:cont, element} # append (it's the first line --> no whitspace)
  def chunkfun(element,acc), do: {:cont, acc <> " " <> element} # append a middle segment

  def getfields(passport) do
    # expects: eyr:2029 byr:1931 hcl:z cid:128 ecl:amb hgt:150cm iyr:2015 pid:14871470
    re = ~r/([a-zA-Z]{3}):(.*)(\s|$)/iU
    Regex.scan(re,passport)
      |> Enum.map(fn [_all,field,val,_end] -> {field,val} end)
  end

  def valid_fields(fields) do
    fields
      |> Enum.filter(&valid?/1)
      |> Enum.map(fn {fld,_val} -> fld end)
  end

  def valid?({"hgt",val}) do
    case Integer.parse(val) do
      {i,"cm"} -> between?(i,150,193)
      {i,"in"} -> between?(i,59,76)
      _ -> false
    end
  end
  def valid?({key,val}) do
    case key do
      "byr" -> between?(val,1920,2002)
      "iyr" -> between?(val,2010,2020)
      "eyr" -> between?(val,2020,2030)
      "hcl" -> Regex.match?(~r/^#(\d|a|b|c|d|e|f){6}$/, val)
      "ecl" -> Regex.match?(~r/^(amb|blu|brn|gry|grn|hzl|oth)$/, val)
      "pid" -> Regex.match?(~r/^\d{9}$/, val)
      _ -> true
    end
  end

  def between?(int,min,max) when is_integer(int), do: (int >= min && int <= max)
  def between?(maybeint,min,max) do
    case Integer.parse(maybeint) do
      {val,""} -> (val >= min && val <= max)
      _ -> false
    end
  end

  def required_fields_present?(fields) do
    diff = @allfields -- fields
    case diff do
      []      -> true
      ["cid"] -> true
      _       -> false
    end
  end
end
