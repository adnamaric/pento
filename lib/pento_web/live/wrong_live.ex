defmodule PentoWeb.WrongLive do
    use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
    alias Pento.Accounts


    def mount(_params, session, socket) do
        IO.inspect session
        {:ok, assign(socket, score: 0, message: "Make a guess:", time: time(), number: number(), winner: false,current_user: Pento.Accounts.get_user_by_session_token(session["user_token"]), 
        session_id: session["live_socket_id"])
        }
    end

    def render(assigns) do
        ~H"""
        <h2>Date and time: <%= @time %></h2>
        <h1>Your current score: <%= @score %></h1>
        <%= if @winner do %>
       <button phx-click="restart"> Restart </button>
       <% end %>
        <h2>
        <%= @message %>
        </h2>
        <h2>
        <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n} ><%= n %></a>
        <% end %>
        <pre>
<%= @current_user.email %>
<%= @session_id %>
</pre>
        </h2>
        """
    end
    
   
    def handle_event("guess", %{"number" => guess}=data, socket) do
        IO.inspect data
        IO.inspect number()
        if guess == number() do
          message = " Congratulations you guessed the number..."
          winner = true
          score = socket.assigns.score + 10
          {:noreply, assign(socket, score: score, message: message, number: number(), winner: winner, time: time())}
        else
        message = "Your guess: #{guess}. Wrong. Guess again."
        score = socket.assigns.score - 1
        {
            :noreply,
            assign(socket, message: message, score: score,time: time())
        }
        end
    end
    def time() do
        DateTime.utc_now |> to_string
    end
    def number() do
        Enum.random(1..10)
        |> to_string
    end
    def handle_event("restart", %{"value" => _}, socket) do
        {
            :noreply,
            assign(socket, score: 0, message: "Guess a number.", number: number(), winner: false)
        }
    end
end