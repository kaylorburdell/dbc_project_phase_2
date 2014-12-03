get '/login' do
  erb :login
end

get '/signup/' do
  erb :signup
end

post '/signup/' do
  user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect ("/")
    else
      #ADD ERROR MSGS
      redirect("/signup/")
    end
end
