defmodule Stripe.Order do
  @moduledoc """
  Work with Stripe SKU objects.

  You can:

  - Create a order
  - Retrieve a order
  - Update a order
  - Delete a order

  Stripe API reference: https://stripe.com/docs/api#orders
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount, :amount_returned, :application, :application_fee,
    :charge, :created, :currency, :customer, :email, :external_coupon_code,
    :items, :livemode, :metadata, :returns, :selected_shipping_method, :shipping,
    :shipping_methods, :status, :status_transitions, :updated, :upstream_id
  ]

  @plural_endpoint "orders"

  @address_map %{
    city: [:create, :retrieve, :update], #required
    country: [:create, :retrieve, :update],
    line1: [:create, :retrieve, :update],
    line2: [:create, :retrieve, :update],
    postal_code: [:create, :retrieve, :update],
    state: [:create, :retrieve, :update]
  }

  @schema %{
    id: [:create, :retrieve, :update],
    object: [:retrieve],
    amount: [:create, :retrieve, :update],
    amount_returned: [:retrieve],
    application: [:create, :retrieve, :update],
    application_fee: [:create, :retrieve, :update],
    charge: [:retrieve],
    created: [:retrieve],
    currency: [:create, :retrieve],
    customer: [:create, :retrieve],
    email: [:create, :retrieve],
    external_coupon_code: [:create, :retrieve],
    items: [:create, :retrieve, :update],#  [%{
    #   object: [:create, :update, :retrieve],
    #   amount: [:create, :update, :retrieve],
    #   currency: [:create, :update, :retrieve],
    #   description: [:create, :update, :retrieve],
    #   parent: [:create, :update, :retrieve],
    #   quantity: [:create, :update, :retrieve],
    #   type: [:create, :update, :retrieve]
    # }],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    returns: %{
      object: [:retrieve],
      data: [:retrieve],
      has_more: [:retrieve],
      total_count: [:retrieve],
      url: [:retrieve]
    },
    shipping: %{
      address: @address_map,
      carrier: [:create, :update, :retrieve],
      name: [:create, :update, :retrieve],
      phone: [:create, :update, :retrieve],
      tracking_number: [:create, :update, :retrieve]
    },
    shipping_methods: %{
      id: [:create, :retrieve, :update],
      amount: [:create, :retrieve, :update],
      currency: [:create, :retrieve, :update],
      delivery_estimate: %{
        date: [:create, :retrieve, :update],
        earliest: [:create, :retrieve, :update],
        latest: [:create, :retrieve, :update],
        type: [:create, :retrieve, :update]
      },
      description: [:create, :retrieve, :update]
    },
    status: [:retrieve],
    status_transitions: %{
      canceled: [:retrieve],
      fulfilled: [:retrieve],
      paid: [:retrieve],
      returned: [:retrieve]
    },
    updated: [:retrieve],
    upstream_id: [:create, :retrieve, :update]
  }

  @nullable_keys [
    :selected_shipping_method
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

  @payment_schema [
    customer: [:create, :retrieve, :update],
    source: [:create, :retrieve, :update]
  ]

  def pay(id, payment_info, opts \\ []) do
    endpoint = @plural_endpoint <> "/" id <> "/pay"
    Stripe.Request.create(@plural_endpoint, payment_info, @payment_schema, __MODULE__, opts)
  end

end
