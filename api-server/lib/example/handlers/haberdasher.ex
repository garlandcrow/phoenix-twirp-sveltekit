defmodule Example.Handlers.HaberdasherHandler do
  @colors ~w|white black brown red blue|
  @names ["bowler", "baseball cap", "top hat", "derby"]

  def make_hat(_ctx, size) do
    if size.inches <= 0 do
      Twirp.Error.invalid_argument("I can't make a hat that small!")
    else
      %Example.Hat{
        inches: size.inches,
        color: Enum.random(@colors),
        name: Enum.random(@names)
      }
    end
  end
end
