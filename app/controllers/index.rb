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

delete '/topic/:id', auth: :user do |id|
  @topic.destroy

  if request.xhr?
    return {deleted: true}.to_json
  else
    redirect to('/topics')
  end
end

get '/topic/:id/edit', auth: :user do |id|
  redirect to '/' unless current_user.may_edit(@topic)
  erb :'topic/_edit_topic', locals: {topic: @topic}
end

put '/topic/:id', auth: :user do |id|
  if current_user.may_edit(@topic)
    @topic.update(params[:topic])
  else
    set_error("Meek Mill - Levels")
  end

  if request.xhr?
    return {topic_text: @topic.text}.to_json
  else
    redirect to("/topic/#{id}")
  end
end
