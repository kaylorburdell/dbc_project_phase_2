def pretty_date(time)
   time.strftime("%d %b %Y")
end

def display_error
  error = session[:error]
  session[:error] = nil
  error
end
