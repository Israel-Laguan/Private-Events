# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :auth_user?, only: %i[new create]
  before_action :signed_in?, :current_user, :set_user, only: %i[show edit update]

  # GET /users
  def index
    @users = User.all
    @current_user = current_user
  end

  # GET /users/1
  def show
    @upcoming_events = @user.attended_events.upcoming_events
    @prev_events = @user.attended_events.prev_events
  end

  # GET /users/new
  def new
    @user = User.new
    @current_user = current_user
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to signin_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
