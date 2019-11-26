defmodule CryptoCoins.Api do
  # Check Tesla Docs
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.coinranking.com/v1/public"
  plug Tesla.Middleware.JSON
  # API Base is: "https://api.coinranking.com/v1/public"
  # Endpoint is: /coins

  # returns {:ok, array_of_coins}
  def coins() do
    #{:ok, result} = get("/coins")
    #{:ok, result.body|>coins}
    with{:ok, %{body: %{"data"=> %{"coins"=>coins}}, status: status} = env} <- get("coins")do
      if status in 200..299 do
        {:ok, coins}
      else
        {:error, env}
      end
    end
  end

  # returns array_of_coins
  #raise if error
  def coins!() do
    with {:ok, coins} <- coins()do
      coins
    else
      e -> raise"Error #{inspect(e)}"
    end
  end
end
