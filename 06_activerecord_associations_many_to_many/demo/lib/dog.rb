class Dog < ActiveRecord::Base
  ## 🚧 🚧 🚧 
  # Rework associations between Dog -> Walks to many-to-many
  has_many :walks
  has_many :feedings

  # 🚧 🚧 🚧 
  # refactor this to use AR query methods instead of filter
  def self.needs_feeding
    self.all.filter do |dog|
      dog.needs_a_meal?
    end
  end

  # 🚧 🚧 🚧 
  # refactor this to use AR query methods instead of filter
  def self.needs_walking
    self.all.filter do |dog|
      dog.needs_a_walk?
    end
  end

  # 🚧 🚧 🚧 
  # add last_walked_at method to query related walks and return either:
  #   the time of the most recent walk or
  #   nil if there is no such walk

  # 🚧 🚧 🚧 
  # add last_fed_at method to query related feedings and return either:
  #   the time of the most recent feeding or
  #   nil if there is no such feeding
  
  
  # 🚧 🚧 🚧 
  # Once these work, we can remove our last_walked_at and last_fed_at columns 
  # these values can both now be calculated from the times stored in the walks
  # and feedings tables.


  # 🚧 🚧 🚧 
  # Once the last_walked_at and last_fed_at methods are built, we'll need to remove 
  # the calls to update those columns within the `walk` and `feed` methods below
  def walk
    now = Time.now
    self.update(last_walked_at: now)
    self.walks.create(time: now)
  end

  def needs_a_walk?
    if !last_walked_at
      true
    else
      last_walked_at < 10.seconds.ago
    end
  end

  def feed
    now = Time.now
    self.update(last_fed_at: now)
    self.feedings.create(time: now)
  end

  def needs_a_meal?
    if !last_fed_at
      true
    else
      last_fed_at < 6.seconds.ago
    end
  end
  
  def print 
    puts ""
    puts name.light_green
    puts "  age: #{age}"
    puts "  breed: #{breed}"
    puts "  favorite_treats: #{favorite_treats}"
    puts "  last walked at: #{last_walked_at}"
    puts "  last fed at: #{last_fed_at}"
    puts ""
  end


end