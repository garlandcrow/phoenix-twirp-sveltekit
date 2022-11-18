defmodule Example.Size do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :inches, 1, type: :int32
end

defmodule Example.Hat do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :inches, 1, type: :int32
  field :color, 2, type: :string
  field :name, 3, type: :string
end