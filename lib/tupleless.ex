defmodule Tupleless do
  @moduledoc """
  Documentation for `Tupleless`.
  """
  @default_wrap_opts [
    error: "There was an unknown error",
    reject: [nil, false],
    addl_reject: []
  ]

  @spec wrap(any(), keyword()) :: {:error, any()} | {:ok, any()}
  @doc """
  Wrap Tupleless functions.

  ## Examples
      iex> Tupleless.wrap(123)
      {:ok, 123}

      iex> Tupleless.wrap(false)
      {:error, "There was an unknown error"}
  """
  def wrap(value, opts \\ []) do
    opts = Keyword.merge(@default_wrap_opts, opts)

    reject =
      (opts[:reject] ++ opts[:addl_reject])
      |> Enum.map(fn
        r when is_function(r) -> if r.(value), do: value, else: r
        r -> r
      end)

    if value in reject, do: {:error, opts[:error]}, else: {:ok, value}
  end

  @doc """
  Unwrap Tuple functions.

  ## Examples
      iex> Tupleless.unwrap({:ok, 123})
      123

      iex> Tupleless.unwrap({:error, "there was an error"})
      nil

  """
  def unwrap({:ok, value}), do: value
  def unwrap({:error, _}), do: nil
end
