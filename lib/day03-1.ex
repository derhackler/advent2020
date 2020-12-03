defmodule Day03_1 do
  @doc """
  Either you do get recursion and pattern matching or not :-)

  Improvement potentials:
  * Horrible to read and hard to debug
  * inefficient: use a bit more math :-)
  """
  @moveright 3
  @movedown 1

  def run do
    input = File.read!(Path.relative_to_cwd("inputs/day03/input.txt")) |> String.split("\n")
    move(@movedown,@moveright,input,"",0,@moveright)
  end

  def move(godown,goright,input,line,trees,offset)
  def move(0,0,input, <<"#",_tl::binary>>,trees,offset), do: move(@movedown,offset+@moveright,input,"",trees + 1,offset+@moveright)
  def move(0,0,input, <<".",_tl::binary>>,trees,offset), do: move(@movedown,offset+@moveright,input,"",trees,offset+@moveright)
  def move(0,right,[hd|_tl] = input, "", trees,offset), do: move(0,right,input,hd,trees,offset) # append to line because we have to move further right
  def move(0,right,input,<<_hd, tl::binary>>, trees,offset), do: move(0,right-1,input,tl,trees,offset) # move 1 field to the right
  def move(down,right,[_hd|rest],_line,trees,offset), do: move(down-1,right,rest,"",trees,offset) # recurse down
  def move(_down,_right,[],_line,trees,_offset), do: trees
end
