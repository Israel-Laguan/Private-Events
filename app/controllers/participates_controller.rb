class ParticipatesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    if already_participate?
      flash[:notice] = "You can't participate more than once"
    else
      @event.participates.create(user_id: current_user.id)
    end
      redirect_to event_path(@event)
  end

  private

  def already_participate?
    Participate.where(user_id: current_user.id, event_id:
    params[:event_id]).exists?
  end
end
