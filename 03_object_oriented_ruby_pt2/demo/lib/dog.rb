class Dog

  @@all = []

  def self.all
    @@all
  end

  def self.create(attributes)
    self.new(attributes).save
  end

  def self.needs_walking
    @@all.filter do |dog|
      dog.needs_a_walk?
    end
  end

  def self.needs_feeding
    @@all.filter do |dog|
      dog.needs_a_meal?
    end
  end

  attr_accessor :name, :age, :breed, :favorite_treats, :last_walked_at, :last_fed_at
  def initialize(name:, age:, breed:, favorite_treats:)
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
  end

  def save
    @@all << self
    self
  end

  def walk
    @last_walked_at = Time.now
  end

  def feed
    @last_fed_at = Time.now
  end

  def print
    puts ""
    puts @name.green
    puts "  Age: #{@age}"
    puts "  Breed: #{@breed}"
    puts "  Favorite Treats: #{@favorite_treats}"
    if needs_a_walk?
      puts "  Last Walked At: #{@last_walked_at}".red
    else
      puts "  Last Walked At: #{@last_walked_at}"
    end
    if needs_a_meal?
      puts "  Last Fed At: #{@last_fed_at}".red
    else
      puts "  Last Fed At: #{@last_fed_at}"
    end
    puts ""
  end

  def needs_a_meal?
    if @last_fed_at
      @last_fed_at < 15.seconds.ago
    else 
      true
    end
  end

  def needs_a_walk?
    if @last_walked_at
      @last_walked_at < 10.seconds.ago
    else
      true
    end
  end

  # given by attr_accessor
  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end


  # def age
  #   @age
  # end

  # def age=(age)
  #   @age = age
  # end

  # def breed
  #   @breed
  # end

  # def breed=(breed)
  #   @breed = breed
  # end

  # def favorite_treats
  #   @favorite_treats
  # end

  # def favorite_treats=(favorite_treats)
  #   @favorite_treats = favorite_treats
  # end

  # def last_walked_at
  #   @last_walked_at
  # end

  # def last_walked_at=(last_walked_at)
  #   @last_walked_at = last_walked_at
  # end

  # def last_fed_at
  #   @last_fed_at
  # end

  # def last_fed_at=(last_fed_at)
  #   @last_fed_at = last_fed_at
  # end

end 
