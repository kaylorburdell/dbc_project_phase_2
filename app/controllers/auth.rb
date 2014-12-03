get '/login' do
  erb :'auth/login'
end

get '/signup' do
  erb :'auth/signup'
end

post '/login' do
  user = User.find_by(alias: params[:alias]).try(:authenticate, params[:password])
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    set_error "Relax, take your time."
    redirect to ('/login')
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

post '/signup' do
  user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect ("/")
    else
      set_error "Relax, take your time."
      redirect to ("/signup?name=#{params[:alias][:email]}")
    end
end
