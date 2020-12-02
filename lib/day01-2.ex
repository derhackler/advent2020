defmodule Day01_2 do
  @doc """
  Same as for day 1 but the calculation is just using list
  comprehension to create the cartesian product of the list
  elements and then does a simple filter.
  """
  def run do
    solution = File.read!(Path.relative_to_cwd("inputs/day01/input.txt"))
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> calculate()

    case solution do
      {a,b,c} -> a * b * c
      :no_solution -> :no_solution
    end

  end

  def calculate(input) do
    permutations = for x <- input, y <- input, z <- input do
      {x,y,z}
    end

    Enum.find(permutations, :no_solution, fn {x,y,z} -> x+y+z == 2020 end)
  end
end
