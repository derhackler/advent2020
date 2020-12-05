defmodule Day06_1 do
  def run do
    Path.relative_to_cwd("inputs/day06/input.txt")
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.chunk_by(fn x -> x == "" end) # split in groups
      |> Stream.filter(fn group -> group != [""] end) # remove the empty groups
      |> Stream.map(&unique_group_answers/1) # get the unique answers
      |> Stream.map(&Enum.count/1)
      |> Enum.sum()
  end

  def unique_group_answers(group) do
    # group is like ["abc","b","ca"]
    group
      |> Enum.flat_map(&String.graphemes/1)
      |> Enum.uniq()
  end
end
