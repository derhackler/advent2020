defmodule Day08_1 do
  def run do
    Path.relative_to_cwd("inputs/day08/input.txt")
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({%{},0}, fn x, {map,cnt} -> {Map.put(map, cnt, parse(x)), cnt+1} end)
      |> elem(0)
      |> run(0,0)
  end

  def parse("nop " <> _something), do: {:nop,0}
  def parse("acc +" <> num), do: {:acc, String.to_integer(num)}
  def parse("acc -" <> num), do: {:acc, -String.to_integer(num)}
  def parse("jmp +" <> num), do: {:jmp, String.to_integer(num)}
  def parse("jmp -" <> num), do: {:jmp, -String.to_integer(num)}

  def run(program,pos,akk) do
    case Map.get(program,pos) do
      {:nop, 0} -> run(Map.delete(program, pos), pos+1, akk)
      {:acc, num} -> run(Map.delete(program, pos), pos+1, akk+num)
      {:jmp, num} -> run(Map.delete(program, pos),pos+num, akk)
      nil -> akk
    end
  end

end
