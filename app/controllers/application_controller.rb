# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :auth_user?

  def sign_in(user)
    remember_token = User.new_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  attr_writer :current_user

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    current_user.present?
  end

  def auth_user?
    redirect_to signin_path, alert: 'You are not Signed in' unless signed_in?
  end
end
