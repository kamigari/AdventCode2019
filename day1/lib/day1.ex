defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  @doc """
  Gets masses from file input.

  ## Examples

      iex> Day1.get_mass_input()
      [50811, 128897, 89996, 149611, 141114, 135923, 111930, 92803, 55111, 114261,
       149401, 121105, 89980, 146337, 128900, 51762, 127032, 57866, 72814, 70392,
       148287, 51967, 55537, 61690, 121273, 122763, 149371, 130761, 109332, 102438,
       116529, 83874, 78013, 75757, 54385, 65358, 94688, 123967, 127817, 115897,
       113593, 99937, 68431, 113574, 115052, 54020, 99599, 133442, 121435, 117860,
       67436, 54157, 147123, 54878, 50710, 105304, 91777, 122063, 61713, 79487,
       149776, 79763, 80542, 86260, 60863, 83083, 127211, 146648, 52711, 90278,
       130288, 77677, 142894, 106849, 103233, 95229, 51169, 127162, 66614, 134157,
       81357, 143084, 127415, 99257, 131490, 117657, 137687, 85974, 80270, 104257,
       141006, 51197, 133995, 62314, 84078, 141718, 140422, 140680, 125301, 59677]

  """

  def get_mass_input() do
    case File.read("lib/input") do
      {:ok, contents} ->
        contents
        |> String.split("\r\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      {:error, reason} ->
        reason
    end
  end

  @doc """
  Calculates fuel from mass.

  ## Examples

      iex> Day1.calculate_fuel(12)
      2
      iex> Day1.calculate_fuel(14)
      2

  """
  def calculate_fuel(mass) do
    mass
    |> div(3)
    |> Kernel.-(2)
  end

  @doc """
  Fuel counter from input file of masses.

  ## Examples

      iex> Day1.fuel_counter()
      3375962

  """
  def fuel_counter() do
    Day1.get_mass_input()
    |> Enum.map(&Day1.calculate_fuel/1)
    |> Enum.sum()
  end

  @doc """
  Calculates negative fuel from mass.

  ## Examples

      iex> Day1.calculate_negative_fuel(1969,0)
      966

  """
  def calculate_negative_fuel(mass, 0) do
    negative_fuel =
      mass
      |> div(3)
      |> Kernel.-(2)

    Day1.calculate_negative_fuel(negative_fuel, negative_fuel)
  end

  def calculate_negative_fuel(mass, sum) do
    negative_fuel =
      mass
      |> div(3)
      |> Kernel.-(2)

    if(negative_fuel > 0) do
      Day1.calculate_negative_fuel(negative_fuel, negative_fuel + sum)
    else
      sum
    end
  end

  @doc """
  Negative fuel counter from input file of masses.

  ## Examples

      iex> Day1.negative_fuel_counter()
      5061072

  """
  def negative_fuel_counter() do
    Day1.get_mass_input()
    |> Enum.map(&Day1.calculate_negative_fuel(&1, 0))
    |> Enum.sum()
  end
end
