defmodule TuplelessTest do
  use ExUnit.Case
  require Integer
  doctest Tupleless

  @default_error "There was an unknown error"

  test "wraps falsey" do
    assert {:error, @default_error} == Tupleless.wrap(nil)
    assert {:error, @default_error} == Tupleless.wrap(false)
  end

  test "wraps falsey with custom error message" do
    assert {:error, @default_error <> "custom"} ==
             Tupleless.wrap(nil, error: @default_error <> "custom")
  end

  @addl_reject [0, "false"]
  test "wraps addl falsey" do
    assert {:error, @default_error} == Tupleless.wrap(0, addl_reject: @addl_reject)
    assert {:error, @default_error} == Tupleless.wrap("false", reject: @addl_reject)
    assert {:error, @default_error} == Tupleless.wrap(nil, addl_reject: @addl_reject)
  end

  @reject [0, "false"]
  test "wraps overwridden falsey" do
    assert {:error, @default_error} == Tupleless.wrap(0, reject: @reject)
    assert {:error, @default_error} == Tupleless.wrap("false", reject: @reject)
    assert {:ok, nil} == Tupleless.wrap(nil, reject: @reject)
  end

  test "wraps falsey from anon func" do
    assert {:error, @default_error} == Tupleless.wrap(1, reject: [&Integer.is_odd/1])
    assert {:ok, 2} == Tupleless.wrap(2, reject: [&Elixir.Integer.is_odd/1])
  end

  test "unwraps ok tuple" do
    assert 123 == Tupleless.unwrap({:ok, 123})
  end

  test "unwraps error tuple" do
    assert nil == Tupleless.unwrap({:error, "there was an error"})
  end
end
