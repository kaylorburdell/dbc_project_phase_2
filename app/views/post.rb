   <h3>by: <%= @post.user.alias %></h3>

      <p><%= @post.content %></p>

      <% if user_can_edit? @post %>

        <%= erb :'_edit_post', locals: {topic: @post} %>

      <% end %>
