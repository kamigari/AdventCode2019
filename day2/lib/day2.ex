defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  @doc """
  Get input for day 2.

  ## Examples

      iex> Day2.get_input()
      %{105 => 13, 48 => 1, 62 => 59, 11 => 3, 39 => 39, 83 => 83, 63 => 63, 34 => 10, 130 => 5, 68 => 1, 26 => 10, 78 => 13, 52 => 1, 15 => 3, 136 => 0, 64 => 1, 75 => 75, 81 => 79, 71 => 71, 129 => 127, 20 => 2, 109 => 13, 50 => 13, 17 => 6, 111 => 111, 25 => 23, 122 => 5, 65 => 9, 125 => 123, 98 => 10, 79 => 79, 13 => 5, 0 => 1, 44 => 1, 8 => 1, 99 => 99, 36 => 1, 67 => 67, 7 => 3, 66 => 63, 85 => 83, 76 => 2, 1 => 0, 32 => 2, 69 => 6, 37 => 35, 126 => 2, 35 => 35, 84 => 2, 104 => 1, 3 => 3, 82 => 9, 119 => 119, 45 => 13, 55 => 55, 6 => 2, 2 => 0, 94 => 91, 49 => 47, 106 => 103, 41 => 39, 118 => 10, 91 => 91, 87 => 87, 33 => 31, 42 => 13, 74 => 13, 120 => 1, 133 => 2, 113 => 111, 60 => 2, 43 => 43, 10 => 4, 70 => 67, 9 => 3, 72 => 2, 132 => 99, 123 => 123, 121 => 119, 86 => 10, 19 => 19, 56 => 1, 116 => 2, 95 => 95, 115 => 115, 128 => 1, 57 => 5, 51 => 51, 101 => 99, 14 => 0, 5 => 1, 54 => 51, 18 => 1, 61 => 10, 103 => 103, 31 => 31, 135 => 0, 22 => 13, 29 => 13, 114 => 9,
      97 => 95, 21 => 19, 89 => 9, 27 => 27, 117 => 115, 107 => 107, 24 => 1, 47 => 47, 100 => 1, 40 => 1, 96 => 1, 131 => 0, 73 => 71, 90 => 87, 30 => 27, 58 => 55, 80 => 1, 88 => 1, 59 => 59, 77 => 75, 23 => 23, 28 => 1, 46 => 43, 102 => 13, 108 => 2, 124 => 1, 134 => 14, 112 => 1, 92 => 1, 53 => 13, 93 => 6, 127 => 127, 110 => 107, 16 => 2, 38 => 9, 4 => 1, 12 => 1}

  """
  def get_input() do
    case File.read("lib/input") do
      {:ok, contents} ->
        list =
          contents
          |> String.split([",", "\r\n"], trim: true)
          |> Enum.map(&String.to_integer/1)

        0..(length(list) - 1) |> Stream.zip(list) |> Enum.into(%{})

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Run program.

  ## Examples

      iex> Day2.run_program(%{0 => 1, 1 => 9, 2 => 10, 3 => 3, 4 => 2, 5 => 3, 6 => 11, 7 => 0, 8 => 99, 9 => 30, 10 => 40, 11 => 50}, 0)
      3_500
  """
  def run_program(program, index \\ 0) do
    case Map.get(program, index) do
      1 ->
        Map.put(
          program,
          Map.get(program, index + 3),
          Map.get(program, Map.get(program, index + 1)) +
            Map.get(program, Map.get(program, index + 2))
        )
        |> run_program(index + 4)

      2 ->
        Map.put(
          program,
          Map.get(program, index + 3),
          Map.get(program, Map.get(program, index + 1)) *
            Map.get(program, Map.get(program, index + 2))
        )
        |> run_program(index + 4)

      99 ->
        Map.get(program, 0)
    end
  end

  @doc """
  Part 1 for day 2.

  ## Examples

      iex> Day2.part_1()
      4_330_636

  """
  def part_1() do
    program = Day2.get_input()
    part_1_program = %{program | 1 => 12, 2 => 2}
    run_program(part_1_program, 0)
  end

  @doc """
  Part 1 for day 2.

  ## Examples

      iex> Day2.part_2()
      6_086

  """
  def part_2() do
    program = Day2.get_input()

    [{_res_program, noun, verb} | _tail] =
      for noun <- 0..99,
          verb <- 0..99 do
        {run_program(%{program | 1 => noun, 2 => verb}, 0), noun, verb}
      end
      |> Enum.filter(fn {res_program, _noun, _verb} -> res_program == 19_690_720 end)

    noun * 100 + verb
  end
end
