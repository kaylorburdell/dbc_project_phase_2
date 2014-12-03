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

get '/topics/:id' do
  @topic = Topic.find(params[:id])
  # @tags = @topic.tags
  erb :topic
end

post '/topic' do
  # puts '*' * 300
  # puts params
  topic = Topic.new(params[:topic])
  # tag = Tag.new(params[:tag])
  # topic.tags << tag
  if topic.save
    redirect("/topics/#{topic.id}")
  else
    session[:error] = topic.errors.messages
    redirect("/topic/new")
  end
end
