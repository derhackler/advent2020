defmodule Day09_1 do
  @seed 25

  def run do
    input = Path.relative_to_cwd("inputs/day09/input.txt")
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)


    resolve([],0,input)
  end

  def resolve(numbers, index, [hd | allnums]) do
    # [{number,[additions]}, ..]

    valid = numbers
              |> Enum.flat_map(fn {_number, additions} -> additions end)
              |> Enum.find(fn x -> x == hd end)

    if valid || index < @seed do
      # add the existing element to each of the number lists
      newnumbers = for {value,l} <- numbers, sum = value + hd, into: [], do: {value,[sum|l]}
      # drop the first element
      newnumbers = if index - @seed > 0, do: tl(newnumbers), else: newnumbers
      # add the new number to the end of the list
      newnumbers = newnumbers ++ [{hd, []}]
      # rerun
      resolve(newnumbers, index+1, allnums)
    else
      hd # the number that is wrong
    end
  end

  def resolve(_numbers, _index, []), do: :no_errors

end
