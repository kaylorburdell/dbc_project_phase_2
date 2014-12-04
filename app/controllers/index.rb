configure do
  set :show_exceptions, false
end

get '/' do
  @topic  = Topic.all
  @topics = @topic.order("updated_at")
  erb :index
end

get '/topic/new' do
  if current_user
    erb :new_topic
  else
    redirect("/login")
  end
end

get '/topic/:id' do
  @topic = Topic.find(params[:id])
  @posts = @topic.posts.order("updated_at")
  erb :topic
end

post '/topic/:id' do
  @topic = Topic.find(params[:id])
  @post = Post.new
  @post.content = params[:post][:content]
  @post.user = current_user
  @post.topic_id = @topic.id
  @post.save
  redirect("/topic/#{@topic.id}")

end

post '/topic', auth: :user do
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

post '/post' do
  if current_user
    @topic = Topic.find(params[:id])
    params[:post][:user_id] = current_user.id
    params[:post][:parent_id] = @topic.id
  @post = Post.new(params[:post])
    if @post.save
      redirect("/topic/#{@topic.id}")
    else
      session[:error] = post.errors.messages
      redirect("../")
    end
  end
end

delete '/topic/:id', auth: :user do |id|
  @topic = Topic.find(params[:id])
  @topic.destroy
  if request.xhr?
    p 'rkelly'
    redirect("/")
  else
    redirect('/')
  end
end

get '/topic/:id/edit', auth: :user do |id|
  @topic = Topic.find(params[:id])
  redirect to '/' unless current_user.may_edit(@topic)
  erb :'_edit_topic', locals: {topic: @topic}
end

put '/topic/:id', auth: :user do |id|
  p 'hello'
  @topic = Topic.find(params[:id])
  if current_user.may_edit(@topic)
    @topic.update(params[:topic])
    redirect("/topic/#{@topic.id}")
  else
    set_error("Meek Mill - Levels")
  end
end
