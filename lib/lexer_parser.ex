defmodule LexerParser do
  @moduledoc """
  TODO
  """

  @doc """
  TODO.

  ## Examples

      iex> LexerParser.evaluate('true and false')
      :false

      iex> LexerParser.evaluate('true and true')
      :true

  """
  def evaluate(expression, variables \\ %{}) do
    with {:ok, tokens, _} <- :business_lexer.string(expression),
         {:ok, tree} <- :business_parser.parse(tokens) do
      evaluate_tree(tree, variables)
    end
  end

  # Tree functions
  # =============

  def evaluate_tree({:binary_expr, op, a, b}, variables) do
    with {:ok, a} <- evaluate_tree(a, variables),
         {:ok, b} <- evaluate_tree(b, variables) do
      apply_logic({:binary_expr, op, a, b}, variables)
    end
  end

  def evaluate_tree({:unary_expr, op, a}, variables) do
    with {:ok, a} <- evaluate_tree(a, variables) do
      apply_logic({:unary_expr, op, a}, variables)
    end
  end

  def evaluate_tree(other, variables) do
    apply_logic(other, variables)
  end

  # Logic functions
  # ==============

  def apply_logic(boolean, _variables) when boolean in [true, false], do: {:ok, boolean}

  def apply_logic({:binary_expr, :and_op, a, b}, _variables)
    when is_boolean(a) and is_boolean(b), do: {:ok, a and b}

  def apply_logic({:var, variable}, variables) do
    case Map.get(variables, variable, nil) do
      nil -> {:error, "variable \"#{variable}\" not provided in: #{inspect variables}"}
      value -> {:ok, value}
    end
  end

  def apply_logic({:unary_expr, :not_op, a}, _)
    when is_boolean(a), do: {:ok, !a}

end
