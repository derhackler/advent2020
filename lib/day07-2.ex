defmodule Day07_2 do
  @doc """
  Compared to Day07-1 I used a dictionary instead a digraph.
  Primarily because I couldn't easily get the labels out of the
  graph again and got annoyed by this.

  Overall the solution feels clumsy and I think is much longer
  than it should be.
  """
  def run do
    bags = Path.relative_to_cwd("inputs/day07/input.txt")
      |> File.stream!()
      |> Stream.map(&parse_rule/1) # split in segments
      |> Enum.reduce(%{},fn [color | bags], acc -> Map.put(acc,color,bags) end)
      |> bags_in_bag_count("shiny gold")
    bags-1 # -1 because the shiny gold bag is counted as well
  end

  def bags_in_bag_count(graph, bag) do
    Map.get(graph,bag)
      |> Enum.reduce(1,fn {childbag,count} , acc -> acc + (count * bags_in_bag_count(graph, childbag)) end)
  end

  def parse_rule(rule) do
    rule
    |> String.split([",","contain"],trim: true)
    |> Enum.map(&extract_colors/1)
    |> Enum.filter(fn x -> x != {} end)
  end

  def extract_colors(rule) do
    case Regex.named_captures(~r/(?<count>\d+)? ?(?<color>[a-z]+ [a-z]+)/, rule) do
      %{"color" => "no other"} -> {}
      %{"count" => count, "color" => color} when count != "" -> {color, String.to_integer(count) }
      %{"color" => color} -> color
      _ -> {}
    end
  end

end
