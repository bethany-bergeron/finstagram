# helper method which will allow us to access the 
# currently logged in user in any ERB file.
helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end


# handle a get request for the index (also called '/'), fetch an array of objects & template the HTML
get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

# handle a get request for the signup page and fetch the template for the signup
get '/signup' do     # if a user navigates to the path "/signup",
  @user = User.new   # setup empty @user object
  erb(:signup)       # render "app/views/signup.erb"
end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    redirect to('/login')
  else
    erb(:signup)
  end
end

# handle a get request for the login page and fetch the template for the login
get '/login' do     # if a user navigates to the path "/lgoin",
  erb(:login)       # render "app/views/login.erb"
end

post '/login' do
  #storing the inputs as variable
  username = params[:username]
  password = params[:password]

  #find_by method can select key value pairs to query in database
  user = User.find_by(username: username)  
  
  #authenticate will bcrypt? to see if the plain text matches the hashed password
  #if user && user.authenticate(password)

  #but since we are storing our passwords as plain text
  #this asks do we have a user and the password is the one they signed up with
  if user && user.password == password
    #updates the cookie, modifying the session hash
    session[:user_id] = user.id
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

#Why do we use the user.id stored in the session hash?
# Main reason is what would be the most basic information that we could use 
# that would allow us to identify a specific user record? Also technically 
# (not a huge deal) the id value is a smaller size of information that we have 
# to send through HTTP. And yeah, using the id value doesn’t disclose any 
# sensitive information about the user.

# from https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html#session-id-content-or-value
# "The session ID must simply be an identifier on the client side, and its value must never include sensitive information"