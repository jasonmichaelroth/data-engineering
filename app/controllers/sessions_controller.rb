class SessionsController < ApplicationController

  # GET /login
  def new
    redirect_to new_import_path if signed_in?
    flash.now.alert = params[:message].humanize if params[:message].present?
  end

  # POST /login
  def create
    auth = request.env["omniauth.auth"]
    session[:user] = {provider: auth['provider'], uid: auth['uid']}
    redirect_to new_import_path, notice: t('authentication.login')
  end

  # GET /logout
  def destroy
    session[:user] = nil
    redirect_to root_path, notice: t('authentication.logout')
  end

end