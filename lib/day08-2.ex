defmodule Day08_2 do
  def run do
    Path.relative_to_cwd("inputs/day08/input.txt")
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({%{},0}, fn x, {map,cnt} -> {Map.put(map, cnt, parse(x)), cnt+1} end)
      |> run()
  end

  def parse("nop +" <> num), do: {:nop, String.to_integer(num)}
  def parse("nop -" <> num), do: {:nop, -String.to_integer(num)}
  def parse("acc +" <> num), do: {:acc, String.to_integer(num)}
  def parse("acc -" <> num), do: {:acc, -String.to_integer(num)}
  def parse("jmp +" <> num), do: {:jmp, String.to_integer(num)}
  def parse("jmp -" <> num), do: {:jmp, -String.to_integer(num)}

  def run({program,_length}) do
    run(program,program,0,0,0)
  end

  def run(origprogram,_program,_flip,pos,akk) when pos == map_size(origprogram)+1, do: akk

  # flip the instructions from nop, to jump when the current statement is at the flip position
  def run(origprogram,program,flip,pos,akk) when flip == pos do
      case Map.get(program,pos) do
        {:nop, num} -> run(origprogram,Map.put(program, pos, :visited),flip, pos+num, akk) # interpret as jump because we're flipping it
        {:acc, num} -> run(origprogram,Map.put(program, pos, :visited),flip, pos+1, akk+num)
        {:jmp, _num} -> run(origprogram,Map.put(program, pos,:visited),flip,pos+1, akk) # interpret as nop because we're flipping it
        :visited -> run(origprogram,origprogram,flip+1,0,0)
        nil -> akk
        _ -> akk
      end
  end

  def run(origprogram,program,flip,pos,akk) do
    case Map.get(program,pos) do
      {:nop, _num} -> run(origprogram,Map.put(program, pos, :visited), flip, pos+1, akk)
      {:acc, num} -> run(origprogram,Map.put(program, pos, :visited),flip, pos+1, akk+num)
      {:jmp, num} -> run(origprogram,Map.put(program, pos, :visited),flip, pos+num, akk)
      :visited -> run(origprogram,origprogram,flip+1,0,0) # reset program and advance the instruction that should be flipped
      nil -> akk
      _ -> akk
    end
end

end
