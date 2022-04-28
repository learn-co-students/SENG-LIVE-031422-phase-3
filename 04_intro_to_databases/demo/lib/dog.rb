class Dog 

  @@all = []

  def self.all
    # We still want to use the @@all class variable so we only have
    # to query the database for all records the first time we invoke
    # this method. 
    # The first call to `.all` should trigger the query and use the
    # results to create and return a collection of dogs which we'll
    # assign to @@all
    # The next call to the method should return the previously 
    # assigned value of @@all
    rows = DB.execute("SELECT * FROM dogs")
    @@all = rows.map do |row|
      self.new_from_row(row)
    end
  end

  def self.new_from_row(row)
    self.new(row.transform_keys(&:to_sym))
  end

  def self.create(attributes) 
    self.new(attributes).save
  end

  def self.needs_feeding
    self.all.filter do |dog|
      dog.needs_a_meal?
    end
  end

  def self.needs_walking
    self.all.filter do |dog|
      dog.needs_a_walk?
    end
  end

  attr_accessor :name, :age, :breed, :favorite_treats, :last_walked_at, :last_fed_at
  attr_reader :id
  def initialize(id: nil, name:, age:, breed:, favorite_treats:, last_walked_at: nil, last_fed_at: nil)
    @id = id
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
    @last_walked_at = last_walked_at
    @last_fed_at = last_fed_at
  end

  def initialize(attributes = {})
    attributes.each do |attr, value|
      self.instance_variable_set("@#{attr}", value)
    end
  end

  def save
    # if the dog has an id, then it's already been saved
    # so we want to trigger an UPDATE to the existing dog
    if id 
      # use a HEREDOC to compose a multi line query
      # https://ruby-doc.org/core-2.7.4/doc/syntax/literals_rdoc.html#label-Here+Documents+-28heredocs-29
      query = <<-SQL
        UPDATE dogs
        SET name = ?,
            age = ?,
            breed = ?,
            favorite_treats = ?,
            last_walked_at = ?,
            last_fed_at = ?
        WHERE
            id = ? 
      SQL
      # add ? marks to any pieces of the query that may come from user input
      # these are called bind params and they're used to escape (or sanitize)
      # anything in this string that has syntactical meaning in SQL like:
      # (), "", ;, etc. The characters will appear in the QUERY string 
      # rather than being interpreted as SQL syntax.
      # https://github.com/sparklemotion/sqlite3-ruby/blob/master/faq/faq.md#how-do-i-use-placeholders-in-an-sql-statement
      # The database requires times to be formatted in a particular way,
      # so we're using the strftime method (string format time) to convert
      # the ruby time objects for last_walked_at and last_fed_at into a string 
      # format that sqlite3 expects
      DB.execute(
        query,
        self.name,
        self.age,
        self.breed,
        self.favorite_treats,
        self.last_walked_at && self.last_walked_at.strftime('%Y-%m-%d %H:%M:%S'),
        self.last_fed_at && self.last_fed_at.strftime('%Y-%m-%d %H:%M:%S'),
        self.id
      )
    else
      # if the dog hasn't been saved yet, we'll trigger an INSERT
      query = <<-SQL
        INSERT INTO dogs 
        (name, age, breed, favorite_treats, last_walked_at, last_fed_at)
        VALUES
        (?, ?, ?, ?, ?, ?)
      SQL
      DB.execute(
        query,
        self.name,
        self.age,
        self.breed,
        self.favorite_treats,
        self.last_walked_at,
        self.last_fed_at
      )
      # Since the dog's id will be assigned by the database
      # we'll need to tell the dog object about the last assigned id
      # we can retrieve that id from the database using the following query
      @id = DB.execute("SELECT last_insert_rowid()")[0]["last_insert_rowid()"]
      # Since the dog has been added to the database just now we should add it
      # to @@all if we've already queried to retrieve all of the dogs
      @@all && @@all << self
    end
    self
  end

  def walk
    self.last_walked_at = Time.now
  end

  def needs_a_walk?
    if !last_walked_at
      true
    else
      last_walked_at < 10.seconds.ago
    end
  end

  def feed
    self.last_fed_at = Time.now
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