defmodule Stripe.SKU do
  @moduledoc """
  Work with Stripe SKU objects.

  You can:

  - Create a SKU
  - Retrieve a SKU
  - Update a SKU
  - Delete a SKU

  Stripe API reference: https://stripe.com/docs/api#skus
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :active, :attributes, :created, :currency, :image, :inventory,
    :livemode, :metadata, :package_dimensions, :price, :product, :updated
  ]

  @plural_endpoint "skus"

  @schema %{
    id: [:create, :retrieve, :update],
    object: [:create, :retrieve, :update],
    active: [:create, :retrieve, :update],
    attributes: [:create, :retrieve, :update],
    created: [:retrieve],
    currency: [:create, :retrieve, :update],
    image: [:create, :retrieve, :update],
    inventory: %{
      quantity: [:create, :retrieve, :update],
      type: [:create, :retrieve, :update],
      value: [:create, :retrieve, :update]
    },
    livemode: [:create, :retrieve, :update],
    metadata: [:create, :retrieve, :update],
    package_dimensions: %{
      height: [:create, :retrieve, :update],
      length: [:create, :retrieve, :update],
      weight: [:create, :retrieve, :update],
      width: [:create, :retrieve, :update]
    },
    price: [:create, :retrieve, :update],
    product: [:create, :retrieve, :update],
    updated: [:retrieve]
  }

  @nullable_keys [
    :package_dimensions, :image
  ]

  @doc """
  Create a SKU.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, __MODULE__, opts)
  end

  @doc """
  Retrieve a SKU.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @spec retrieve_many(Keyword.t) :: {:ok, boolean, [t]} | {:error, Stripe.api_error_struct}
  def retrieve_many(opts \\ []) do
    query =
      %{}
      |> Util.put_if_non_nil_opt(:starting_after, opts)
      |> Util.put_if_non_nil_opt(:ending_before, opts)
      |> Util.put_if_non_nil_opt(:limit, opts)
      |> URI.encode_query
    endpoint = @plural_endpoint <> "?" <> query
    Stripe.Request.retrieve_many(endpoint, __MODULE__, opts)
  end

  @spec retrieve_all(Keyword.t) :: {:ok, [t]} | {:error, Stripe.api_error_struct}
  def retrieve_all(opts \\ []) do
    Stripe.Request.retrieve_all(fn opts_list -> retrieve_many(opts_list) end, opts)
  end

  @doc """
  Update a SKU.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, __MODULE__, opts)
  end

  @doc """
  Delete a SKU.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end

end
