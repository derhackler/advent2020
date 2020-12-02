defmodule Day01_1 do
  @doc """
  A brutal brute force variant to solve the first advent of code puzzle.
  It heavily uses recursion and pattern matching which makes it a bit hard
  to read in my opinion. For a more denser version see Day01_2

  Improvement ideas:
  * sort first and kind of break the loop when a theoretical solution is not possible anymore
  *
  """
  def run do
    solution = File.stream!(Path.relative_to_cwd("inputs/day01/input.txt"))
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.map(&String.to_integer/1)
      |> calculate([])

    case solution do
      {a,b} -> a * b
      :no_solution -> :no_solution
    end
  end

  def calculate(_the_list, [{a,b}]), do: {a,b} # a solution was found
  def calculate([], []), do: :no_solution # no solution was found
  def calculate([hd|tl],_empty_list) do # search is not over yet
    sol = Enum.map(tl, fn b -> {hd,b} end) # create pairs
    |> Enum.filter(&is2020/1)
    calculate(tl,sol)
  end

  def is2020({a,b}) when a+b == 2020 do true end
  def is2020(_x) do false end
end


"""
--- Day 1: Report Repair ---
After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.

The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.

To save your vacation, you need to get all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.

Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

For example, suppose your expense report contained the following:

1721
979
366
299
675
1456
In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

Your puzzle answer was 357504.

--- Part Two ---
The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

In your expense report, what is the product of the three entries that sum to 2020?

Your puzzle answer was 12747392.
"""
