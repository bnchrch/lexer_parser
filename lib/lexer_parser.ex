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
  def evaluate(expression) do
    with {:ok, tokens, _} <- :business_lexer.string(expression),
         {:ok, tree} <- :business_parser.parse(tokens) do
      evaluate_tree(tree)
    end
  end

  # Tree functions
  # =============

  def evaluate_tree({:binary_expr, op, a, b}) do
    with {:ok, a} <- evaluate_tree(a),
         {:ok, b} <- evaluate_tree(b) do
      apply_logic({:binary_expr, op, a, b})
    end
  end

  def evaluate_tree(other) do
    apply_logic(other)
  end

  # Logic functions
  # ==============

  def apply_logic(boolean) when boolean in [true, false], do: {:ok, boolean}

  def apply_logic({:binary_expr, :and_op, a, b})
    when is_boolean(a) and is_boolean(b), do: {:ok, a and b}

end
