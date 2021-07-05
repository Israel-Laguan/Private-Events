# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  has_many :user_events
  has_many :attendees, -> { distinct }, through: :user_events, source: 'user'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_feedbacks
  has_many :users, through: :user_feedbacks


  scope :today_events, -> {where('date == ?', Date.today) }
  scope :upcoming_events, -> { where('date > ?', Date.today) }
  scope :prev_events, -> { where('date < ?', Date.today) }
end
