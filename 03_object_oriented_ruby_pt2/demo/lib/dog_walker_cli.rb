DOGS = [
  Dog.new("Lennon Snow", "almost 2", "Pomeranian", "Cheese")
]

def start_cli
  puts "Hi there! Welcome to the Dog Walker CLI".cyan
  print_menu_options
  loop do
    handle_choice(ask_for_choice)
    print_menu_options
  end
end

def print_menu_options
  puts "What would you like to do?".cyan
  puts "  1. Add a Dog"
  puts "  2. List Dogs"
  puts "  3. To walk a Dog"
  puts "  4. To feed a Dog"
  puts "type 'menu' to see these choices again"
  puts "or type exit at any point to leave the program"
end

def ask_for_choice
  choice = gets.chomp
  if choice == "exit"
    puts "Thanks for using the Dog Walker CLI! Have a nice day :)"
    exit 
  else
    choice
  end
end

def handle_choice(choice)
  if choice == "1"
    add_dog
  elsif choice == "2"
    list_dogs
  elsif choice == "3"
    walk_dog
  elsif choice == "4"
    feed_dog
  elsif choice == "debug"
    binding.pry
  elsif choice == "menu"
    print_menu_options
  else
    "Whoops! I didn't understand that choice, please try again.".red
  end
end

def add_dog
  print "What's your dog's name? "
  name = ask_for_choice
  print "What's your dog's age? "
  age = ask_for_choice
  print "What's your dog's breed? "
  breed = ask_for_choice
  print "What's your dog's favorite treats? "
  favorite_treats = ask_for_choice
  # dog_hash = {
  #   name: dog_name,
  #   age: dog_age,
  #   breed: dog_breed,
  #   favorite_treats: dog_favorite_treats
  # }
  # DOGS << dog_hash
  # print_dog(dog_hash)
  dog = Dog.new(name, age, breed, favorite_treats)
  DOGS << dog
  dog.print
end

def list_dogs
  DOGS.each do |dog|
    dog.print
  end
end

def walk_dog
  puts "Choose a dog to walk by its corresponding number"
  DOGS.each.with_index(1) do |dog, num|
    puts "#{num}. #{dog.name}"
  end
  index = ask_for_choice.to_i - 1
  dog = DOGS[index]
  until dog
    puts "Whoops! Please choose a number from the choices above".red
    index = ask_for_choice.to_i - 1
    dog = DOGS[index]
  end
  dog.walk
  dog.print
end

def feed_dog
  puts "Choose a dog to feed by its corresponding number"
  DOGS.each.with_index(1) do |dog, num|
    puts "#{num}. #{dog.name}"
  end
  index = ask_for_choice.to_i - 1
  dog = DOGS[index]
  # run a loop until we get a dog from their input
  until dog
    # while we don't have a dog give them an error
    # and ask again
    puts "Whoops! Please choose a number from the choices above".red
    index = ask_for_choice.to_i - 1
    dog = DOGS[index]
  end
  dog.feed
  dog.print
end