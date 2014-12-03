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

delete '/topic/:id', auth: :user do |id|
  @topic.destroy

  if request.xhr?
    return {deleted: true}.to_json
  else
    redirect to('/topics')
  end
end

get '/topic/:id/edit', auth: :user do |id|
  redirect to '/subs' unless current_user.may_edit(@topic)
  erb :'topic/_update_form', locals: {topic: @topic}
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
