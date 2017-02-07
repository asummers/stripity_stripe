defmodule Stripe.Product do
  @moduledoc """
  Work with Stripe SKU objects.

  You can:

  - Create a product
  - Retrieve a product
  - Update a product
  - Delete a product

  Stripe API reference: https://stripe.com/docs/api#products
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id,
    :active, :attributes, :caption, :created, :deactivate_on,
    :description,:images, :livemode, :metadata, :name, :package_dimensions,
    :shippable, :skus, :updated, :url
  ]

  @plural_endpoint "products"

  @schema %{
    id: [:create, :retrieve, :update],
    object: [:retrieve],
    active: [:create, :retrieve, :update],
    attributes: [:create, :retrieve, :update],
    caption: [:create, :retrieve, :update],
    created: [:retrieve],
    deactivate_on: [:create, :retrieve, :update],
    description: [:create, :retrieve, :update],
    images: [:create, :retrieve, :update],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    name: [:create, :retrieve, :update],
    package_dimensions: %{
      height: [:create, :retrieve, :update],
      length: [:create, :retrieve, :update],
      weight: [:create, :retrieve, :update],
      width: [:create, :retrieve, :update]
    },
    shippable: [:create, :retrieve, :update],
    skus: %{
      object: [:retrieve],
      data: [
        ## HERE
      ],
      has_more: [:retrieve],
      total_count: [:retrieve],
      url: [:retrieve]
    }
  }

  @nullable_keys [
    :package_dimensions
  ]

  @doc """
  Create a product.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, __MODULE__, opts)
  end

  @doc """
  Retrieve a product.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update a product.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, __MODULE__, opts)
  end

  @doc """
  Delete a product.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end
