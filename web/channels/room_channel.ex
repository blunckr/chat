defmodule Chat.RoomChannel do
  use Phoenix.Channel
  alias Chat.Message

  def join("rooms:" <> room_id, _params, socket) do
    # room = Repo.get!(Room, room_id)
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body, "username" => user}, socket) do
    [_, room_id] = socket.topic |> String.split(":")
    changeset = Message.changeset(%Message{}, %{content: body, user: user, room_id: room_id})
    Chat.Repo.insert(changeset)
    {:noreply, socket}
  end
end
