require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.order(:name)
  erb :'meetups/index'
end

get '/meetups/:id' do
  @meetup_info = Meetup.find(params[:id])
  @creator = Membership.find_by(creator: true, meetup_id: @meetup_info.id)
  @members = Membership.where(meetup_id: @meetup_info.id)
  erb :'meetups/show'
end

get '/new' do
  @current_user = current_user
  erb :'meetups/new'
end

post '/new' do
  @meetup_info = Meetup.new(
    name: params["name"],
    location: params["location"],
    description: params["description"],
    user_id: current_user.id
  )
  if @meetup_info.save
    @members = Membership.create(
      user_id: current_user.id,
      meetup_id: @meetup_info.id,
      creator: true
    )
    flash[:notice] = "Meetup Successfully Created!"
    redirect "meetups/#{@meetup_info.id}"
  else
    flash.now[:notice] = @meetup_info.errors.full_messages.join(", ")
    erb :'meetups/new'
  end
end

post '/join/:id' do
  @meetup_info = Meetup.find(params[:id])
  @creator = Membership.find_by(creator: true, meetup_id: @meetup_info.id)
  @members = Membership.where(meetup_id: @meetup_info.id)
  erb :'meetups/show'

  current_members = []
  @members.each do |member|
    current_members << member.user.username
  end

  if @current_user.nil?
    flash[:notice] = "Please sign in before joining a Meetup."
    redirect "meetups/#{@meetup_info.id}"
  elsif current_members.include?(@current_user.username)
    flash[:notice] = "You are already signed up for this Meetup."
    redirect "meetups/#{@meetup_info.id}"
  else
    flash[:notice] = "You successfully joined this Meetup!"
    @new_member = Membership.create(
    user_id: current_user.id,
    meetup_id: @meetup_info.id
    )
    redirect "meetups/#{@meetup_info.id}"
  end

end
