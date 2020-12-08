defmodule Day09_2 do

  @doc """
  I don't like the code. Should be possible to
  do via a reducer as well. The resolve method is too long
  and too complex
  """
  @seed 25

  def run do
    input = Path.relative_to_cwd("inputs/day09/input.txt")
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)

    errornumber = resolve([],0,input)

    findset(2, input, errornumber)
  end

  def findset(1000, _input, _target), do: :max_chunk_size_reached
  def findset(size, input, target) do
    found = input
      |> Enum.chunk_every(size,1)
      |> Enum.map(fn chunk -> {Enum.sum(chunk),chunk} end)
      |> Enum.filter(fn {sum,_chunk} -> sum == target end)

    case found do
      [] -> findset(size+1, input, target)
      [{_sum,chunk}] -> Enum.min(chunk) + Enum.max(chunk)
      _ -> :multiple_solutions
    end
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
