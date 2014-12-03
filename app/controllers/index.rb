configure do
  set :show_exceptions, false
end

get '/' do
  # @forums = Forum.all
  erb :index
end

get '/login/' do
  erb :login
end

get '/logout/' do
  session.clear
  redirect ("/")
end
