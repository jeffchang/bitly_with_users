require 'bcrypt'

get '/' do
  # Look in app/views/index.erb
  @user = User.find(session[:user_id]) if session[:user_id]
  erb :index

end

get '/logout' do 
  session[:user_id] = nil
  erb :index
end



post '/create' do

  erb :create
end

post '/save' do
  params[:password] = BCrypt::Password.create(params[:password])
  @user = nil
  @user = User.create(params) if User.where(:email => params[:email]).empty?
  session[:user_id] = @user.id
  erb :index
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  unless @user.nil?
    session[:user_id] = @user.id
    erb :secret
  else
    erb :index
  end
end

post '/secret' do
  @user = User.find(session[:user_id])
  erb :secret
end