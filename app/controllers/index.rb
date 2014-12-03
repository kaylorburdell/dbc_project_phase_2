configure do
  set :show_exceptions, false
end

get '/' do
  # @forums = Forum.all
  erb :index
end

get '/topic/new' do
  if current_user
    erb :new_topic
  else
    redirect("/login")
  end
end

# get '/topics/:id' do |id|
#   erb :'/topic', locals: {topic: @topic}
# end

get '/topic/:id' do
  @topic = Topic.find(params[:id])
  erb :topic
end

post '/topic/:id' do
  @topic = Topic.find(params[:id])
  @post = Post.new
  @post.content = params[:post][:content]
  @post.user = current_user
  @post.topic_id = @topic.id
  @post.save

end

post '/topic', auth: :user do
  # puts '*' * 300
  # puts params
  params[:topic][:user_id] = current_user.id
  @topic = Topic.create(params[:topic])
  if @topic.save
    redirect("/topic/#{@topic.id}")
    # erb :'/topic', locals: {topic: @topic}
  else
    session[:error] = topic.errors.messages
    redirect("/topic/new")
  end
end

get '/post/:id' do
  @post = Post.find(params[:id])
  erb :display_post
end

put '/post' do
  redirect("/topic/#{@topic.id}")
end

put '/post/:id' do |id|
  wiki = Wiki.find(id)
  if wiki.update(params[:wiki])
    wiki.create_revision(params[:revision][:content], current_user)
    redirect("/wiki/#{wiki.id}")
  else
    session[:error] = wiki.errors.messages
    redirect("/wiki/#{wiki.id}/edit")
  end
end

post '/post' do
  if current_user
    @topic = Topic.find(params[:id])
    params[:post][:user_id] = current_user.id
    params[:post][:parent_id] = @topic.id
  @post = Post.create(params[:post])
    if @post.save
      # ALL THIS IS MESSED UP
      redirect("/topic/#{@topic.id}")
      # erb :'/topic', locals: {topic: @topic}
    else
      session[:error] = post.errors.messages
      redirect("../")
    end
  else
  end
end

delete '/topic/:id', auth: :user do |id|
  @topic.destroy

  if request.xhr?
    return {deleted: true}.to_json
  else
    redirect to('/topics')
  end
end

get '/topic/:id/edit', auth: :user do |id|
  @topic = Topic.find(params[:id])
  redirect to '/' unless current_user.may_edit(@topic)
  erb :'_edit_topic', locals: {topic: @topic}
end

put '/topic/:id', auth: :user do |id|
  @topic = Topic.find(params[:id])
  if current_user.may_edit(@topic)
    @topic.update(params[:topic])
    erb :'topic'
  else
    set_error("Meek Mill - Levels")
  end

  # if request.xhr?
  #   return {topic_text: @topic.text}.to_json
  # else
  #   redirect to("/topic/#{id}")
  # end
end
