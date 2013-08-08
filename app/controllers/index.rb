require 'bcrypt'
require 'securerandom'

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
    redirect '/secret'
  else
    erb :index
  end
end

access_secret = lambda do
  @user = User.find(session[:user_id])
  @urls = Url.where(user_id: @user.id) || []
  erb :secret
end

post '/secret', &access_secret
get '/secret', &access_secret


create_url = lambda do
  url_creation_logic
end

post '/urls', &create_url
get '/urls', &create_url

get '/invalid_url' do
  erb :invalid_url
end

get '/:short_url' do
  url = Url.where(short_url: params[:short_url]).first
  url.click_count += 1
  url.save
  redirect url.url
end