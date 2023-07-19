defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    answer = :rand.uniform(10)
    IO.puts(answer)
    {:ok, assign(socket, score: 0, message: "Make a guess:", answer: answer)}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%=  @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link  href='#' phx-click="guess" phx-value-number={n} >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    answer = socket.assigns.answer

    case String.to_integer(guess) do
      ^answer ->
        {
          :noreply,
          assign(
            socket,
            message: "Your guess: #{guess}. Bravo!",
            score: socket.assigns.score + 1
          )
        }

      _ ->
        {
          :noreply,
          assign(
            socket,
            message: "Your guess: #{guess}. Wrong. Guess again. ",
            score: socket.assigns.score - 1
          )
        }
    end
  end
end
