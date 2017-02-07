defmodule Stripe.URI do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      defp build_url(ext \\ "") do
        if ext != "", do: ext = "/" <> ext

        @base <> ext
      end
    end
  end

  @doc """
  Takes a map and turns it into proper query values.

  ## Example
  card_data = %{
    card: %{
      number: 424242424242,
      exp_year: 2014
    }
  }

  Stripe.URI.encode_query(card) # card[number]=424242424242&card[exp_year]=2014
  """
  def encode_query(map) do
    map |> UriQuery.params |> URI.encode_query
  end
end
