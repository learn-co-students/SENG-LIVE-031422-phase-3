class DogWalk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walk

  scope :with_poop, -> { where(pooped: true) }
  # equivalent to
  # def self.with_poop
  #   where(pooped: true)
  # end

  delegate :formatted_time, to: :walk
  # equivalent to
  # def formatted_time
  #   walk.formatted_time
  # end

  def walk_time=(time)
    self.walk = Walk.create(time: time)
  end

 
end