# Generated by the protobuf compile. DO NOT EDIT!

defmodule Example.HaberdasherService do
  @moduledoc false
  use Twirp.Service

  package "example"
  service "Haberdasher"

  rpc :MakeHat, Example.Size, Example.Hat, :make_hat
end

defmodule Example.HaberdasherClient do
  @moduledoc """
  Generated Twirp Client
  """

  @package "example"
  @service "Haberdasher"

  @type ctx :: map()

  @callback make_hat(ctx(), Example.Size.t()) ::
              {:ok, Example.Hat.t()} | {:error, Twirp.Error.t()}

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  @doc """
  Starts a new service client.

  ## Options
  * `:url` - The root url for the service.
  * `:content_type` - Either `:proto` or `:json` based on the desired client type. Defaults to `:proto`.
  * `:pool_config` - Configuration for the underlying Finch, http pool.
  """
  def start_link(opts) do
    url = opts[:url] || raise ArgumentError, "#{__MODULE__} requires a `:url` option"
    content_type = opts[:content_type] || :proto
    full_path = Path.join([url, "twirp", "#{@package}.#{@service}"])
    interceptors = opts[:interceptors] || []

    {adapter_mod, adapter_opts} =
      opts[:adapter] || {Twirp.Client.Finch, pools: %{default: [size: 10, count: 1]}}

    http_opts = %{
      name: __MODULE__,
      opts: adapter_opts
    }

    :persistent_term.put({__MODULE__, :url}, full_path)
    :persistent_term.put({__MODULE__, :content_type}, content_type)
    :persistent_term.put({__MODULE__, :interceptors}, interceptors)
    :persistent_term.put({__MODULE__, :adapter}, {adapter_mod, adapter_opts})
    Twirp.Client.HTTP.start_link(adapter_mod, http_opts)
  end

  @doc """
  MakeHat produces a hat of mysterious, randomly-selected color!
  """
  @spec make_hat(ctx(), Example.Size.t()) :: {:ok, Example.Hat.t()} | {:error, Twirp.Error.t()}
  def make_hat(ctx \\ %{}, %Example.Size{} = req) do
    rpc(:MakeHat, ctx, req, Example.Size, Example.Hat)
  end

  defp rpc(method, ctx, req, input_type, output_type) do
    service_url = :persistent_term.get({__MODULE__, :url})
    interceptors = :persistent_term.get({__MODULE__, :interceptors})
    {adapter_mod, _} = :persistent_term.get({__MODULE__, :adapter})
    content_type = Twirp.Encoder.type(:persistent_term.get({__MODULE__, :content_type}))
    content_header = {"Content-Type", content_type}

    ctx =
      ctx
      |> Map.put(:content_type, content_type)
      |> Map.update(:headers, [content_header], &[content_header | &1])
      |> Map.put_new(:deadline, 1_000)

    rpcdef = %{
      service_url: service_url,
      method: method,
      req: req,
      input_type: input_type,
      output_type: output_type
    }

    metadata = %{
      client: __MODULE__,
      method: method,
      service: service_url
    }

    start = Twirp.Telemetry.start(:rpc, metadata)

    call_chain =
      chain(Enum.reverse(interceptors), fn ctx, req ->
        case Twirp.Client.HTTP.call(adapter_mod, __MODULE__, ctx, %{rpcdef | req: req}) do
          {:ok, resp} ->
            Twirp.Telemetry.stop(:rpc, start, metadata)
            {:ok, resp}

          {:error, error} ->
            metadata = Map.put(metadata, :error, error)
            Twirp.Telemetry.stop(:rpc, start, metadata)
            {:error, error}
        end
      end)

    call_chain.(ctx, req)
  end

  defp chain([], f), do: f

  defp chain([func | fs], acc_f) do
    next = fn ctx, req ->
      func.(ctx, req, acc_f)
    end

    chain(fs, next)
  end
end