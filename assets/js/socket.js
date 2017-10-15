// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

let channel = socket.channel("updates:all")
// https://medium.com/elixir-magic/writing-a-blog-engine-in-phoenix-and-elixir-part-9-live-comments-9269669a6941
// http://learningelixir.joekain.com/pushing-model-changes-to-a-phoenix-channel/
$(function() {
    if (!$("#posts-feed").length > 0) {
      // Wrong page.
      return
    }

    const createMessage = (payload) => `
        <div id="post-${payload.id}" class="card text-center mb-3">
            <div class="card-body">
                <h4 class="card-title">${payload.title}</h4>
                <p class="card-subtitle lead">${payload.description}</p>
                <p><small class="card-text text-muted">by <%= link("@" <> ${payload.username}, to: user_path(@conn, :show, ${payload.user_id})) %></small></p>
                <%= link "Read More", to: post_path(@conn, :show, ${payload.id}), class: "btn btn-info" %>
            </div>
            <div class="card-footer"><small class="text-muted">Posted ${payload.inserted_at}</small></div>
        </div>
    `
    //  +
    //  +channel.on("new_msg", payload => {
    //  +  console.log('channel received new message', payload)
    //  +  let messagesList = document.querySelector("#messages")
    //  +
    //  +  if (messagesList) {
    //  +    let messageItem = buildMessageItem(payload);
    //  +    messagesList.prepend(messageItem)
    //  +  }
    //  +})

    channel.on("new_message_posted", payload => {
        console.log(payload);
        // let posts_feed = $($("#posts-feed")[0])
        if ($(`#post-${payload.id}`).length === 0) {
            console.log("new message posted?")
            $("#posts-feed").before(
            createMessage(payload)
            )
        }
    })
    // Join the topic
    // let channel = socket.channel(topic, {})

    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
})



// Now that you are connected, you can join channels with a topic:
// let channel = socket.channel("topic:subtopic", {})


export default socket
