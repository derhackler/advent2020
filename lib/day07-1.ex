defmodule Day07_1 do
  def run do
    graph = :digraph.new()

    # build the graph
    Path.relative_to_cwd("inputs/day07/input.txt")
      |> File.stream!()
      |> Stream.map(&extract_rule/1) # split in segments
      |> Enum.each(fn x -> add_to_graph(x,graph) end)

    cnt = graph
      |> find_bags_for("shiny gold")
      |> Enum.sort()
      |> Enum.dedup()
      |> Enum.count() # count is off by one because it includes the first vertex

    cnt - 1
  end

  def extract_rule(rule) do
    rule
    |> String.split([",","contain"],trim: true)
    |> Enum.map(&extract_colors/1)
    |> Enum.filter(fn x -> x != {} end)
  end

  def find_bags_for(graph, vertex) do
    n = :digraph.in_neighbours(graph,vertex)
      |> Enum.flat_map(fn x -> find_bags_for(graph, x) end)
    [vertex | n]
  end

  def add_to_graph([{parentcolor,:none}|childbags], graph) do
    :digraph.add_vertex(graph,parentcolor)
    for {color,count} <- childbags do
      :digraph.add_vertex(graph,color)
      :digraph.add_edge(graph,parentcolor,color,count)
    end
  end

  def extract_colors(rule) do
    case Regex.named_captures(~r/(?<count>\d+)? ?(?<color>[a-z]+ [a-z]+)/, rule) do
      %{"color" => "no other"} -> {}
      %{"count" => count, "color" => color} when count != "" -> {color, String.to_integer(count) }
      %{"color" => color} -> {color,:none}
      _ -> {}
    end
  end

end
