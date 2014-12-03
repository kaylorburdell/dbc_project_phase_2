def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  else
    return nil
  end
end

def set_error(error)
  session[:error] = error
end

def display_error
  if session[:error]
    error = session[:error]
    session[:error] = nil
    return "<p>Error: #{error}</p>"
  end
end
