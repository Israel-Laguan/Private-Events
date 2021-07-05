class UserFeedbacksController < ApplicationController
  before_action :set_event

	def create
		@user_feedback = @event.user_feedbacks.new(feedback_params)
		@user_feedback.save
		redirect_back(fallback_location: root_path)
	end

	private

	def feedback_params
		params.require(:user_feedback).permit(:comment, :rating, :event_id, :user_id)
	end

	def set_event
		@event = Event.find(params[:event_id])
	end
end
