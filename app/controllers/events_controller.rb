# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :signed_in?, :set_event, only: %i[show edit update destroy]

  # GET /events
  def index
    @today_events = Event.today_events
    @upcoming_events = Event.upcoming_events
    @prev_events = Event.prev_events
  end

  # GET /events/1
  def show
    @current_user = current_user
    @comment = Comment.new
    @comments = @event.comments.order("created_at DESC")
    @answer = Answer.new
    @feedbacks = @event.user_feedbacks
    @user_feedback = UserFeedback.new
  end

  # GET /events/new
  def new
    @current_user = current_user
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @current_user = current_user
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  def attend_event
    @user_event = current_user.user_events.build(event_id: params[:id])
    @event = Event.find(params[:id])
    if @user_event.save
      redirect_to @event, notice: 'Event was successfully followed.'
    else
      flash.now[:alert] = 'There was a problem following the event'
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:date, :location, :description)
  end
end
