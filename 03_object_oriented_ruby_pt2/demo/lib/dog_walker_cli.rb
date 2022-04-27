
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
  puts "  5. To view dogs that need walking"
  puts "  6. To view dogs that need feeding"
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
  elsif choice == "5"
    dogs_that_need_walking
  elsif choice == "6"
    dogs_that_need_feeding
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

  dog = Dog.create(
    name: name, 
    age: age, 
    breed: breed, 
    favorite_treats: favorite_treats
  )
  dog.print
end

def list_dogs
  Dog.all.each do |dog|
    dog.print
  end
end

def walk_dog
  puts "Choose a dog to walk by its corresponding number"
  Dog.all.each.with_index(1) do |dog, num|
    puts "#{num}. #{dog.name}"
  end
  index = ask_for_choice.to_i - 1
  dog = Dog.all[index]
  until dog
    puts "Whoops! Please choose a number from the choices above".red
    index = ask_for_choice.to_i - 1
    dog = Dog.all[index]
  end
  dog.walk
  dog.print
end

def feed_dog
  puts "Choose a dog to feed by its corresponding number"
  Dog.all.each.with_index(1) do |dog, num|
    puts "#{num}. #{dog.name}"
  end
  index = ask_for_choice.to_i - 1
  dog = Dog.all[index]
  # run a loop until we get a dog from their input
  until dog
    # while we don't have a dog give them an error
    # and ask again
    puts "Whoops! Please choose a number from the choices above".red
    index = ask_for_choice.to_i - 1
    dog = Dog.all[index]
  end
  dog.feed
  dog.print
end

# main menu option 5
def dogs_that_need_walking
  dogs_that_need_walking = Dog.needs_walking
  if dogs_that_need_walking.empty?
    puts "Everybody is walked!".green
  else
    puts "Here are all the dogs that need walking".blue
    dogs_that_need_walking.each do |restless_dog|
      restless_dog.print
    end
  end
end

# main menu option 6
def dogs_that_need_feeding
  dogs_that_need_feeding = Dog.needs_feeding
  if dogs_that_need_feeding.empty?
    puts "Everybody is fed!".green
  else
    puts "Here are all the dogs that need feeding".blue
    dogs_that_need_feeding.each do |hungry_dog|
      hungry_dog.print
    end
  end
end