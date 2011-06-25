class SessionsController < ApplicationController

  def new
    # default to Facebook for now, could eventually let the user choose
    redirect_to '/auth/facebook'
  end

  def create
    omniauth = request.env['omniauth.auth']
    user = User.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first || User.create_with_omniauth(omniauth)

    session[:user_id] = user.id

    redirect_to expenses_url, :notice => 'Successfully signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Successfully signed out!'
  end

  # callback for omniauth authentication failure
  def failure
    redirect_to root_url, :alert => 'Authentication failure: #{params[:message].humanize}'
  end

end