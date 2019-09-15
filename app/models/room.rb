class Room < ApplicationRecord
  has_many :reviews, :dependent => :destroy
  has_many :reviewed_rooms, :through => :reviews, :source => :room
  belongs_to :user
  validates_presence_of :title, :location, :description
  mount_uploader :picture, PictureUploader

  def complete_name
    "#{title}, #{location}"
  end


  def self.most_recent
    order(created_at: :desc)
  end

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      where(['location LIKE :query OR
title LIKE :query OR
description LIKE :query', :query => "%#{query}%"])
    else
      unscoped
    end
  end

end
