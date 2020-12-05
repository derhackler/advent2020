defmodule Day05_1 do

  def run do
    File.stream!(Path.relative_to_cwd("inputs/day05/input.txt"))
      |> Stream.map(&String.trim/1)
      |> Stream.map(fn seat -> seat({0,0},{64,4},seat) end)
      |> Enum.max()
    #   |> Stream.chunk_while("",&chunkfun/2, fn acc -> {:cont, acc,""} end )
    #   |> Stream.map(&getfields/1) # --> [[{"fld",val},..],[..]]
    #   |> Stream.map(&valid_fields/1)
    #   |> Stream.filter(&required_fields_present?/1)
    #   |> Enum.count()
  end

  def seat({row,col},{_maxrow,_maxcol},""), do: row*8+col
  def seat({row,col},{maxrow,maxcol},"F" <> rest), do: seat({row,col},{maxrow/2,maxcol},rest)
  def seat({row,col},{maxrow,maxcol},"B" <> rest), do: seat({row+maxrow,col},{maxrow/2,maxcol},rest)
  def seat({row,col},{maxrow,maxcol},"L" <> rest), do: seat({row,col},{maxrow,maxcol/2},rest)
  def seat({row,col},{maxrow,maxcol},"R" <> rest), do: seat({row,col+maxcol},{maxrow,maxcol/2},rest)
end
