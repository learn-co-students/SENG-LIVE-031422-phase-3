DOGS = []

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
  dog_name = ask_for_choice
  print "What's your dog's age? "
  dog_age = ask_for_choice
  print "What's your dog's breed? "
  dog_breed = ask_for_choice
  print "What's your dog's favorite treats? "
  dog_favorite_treats = ask_for_choice
  dog_hash = {
    name: dog_name,
    age: dog_age,
    breed: dog_breed,
    favorite_treats: dog_favorite_treats
  }
  DOGS << dog_hash
  print_dog(dog_hash)
end

def print_dog(dog_hash)
  puts ""
  puts dog_hash[:name].green
  puts "  Age: #{dog_hash[:age]}"
  puts "  Breed: #{dog_hash[:breed]}"
  puts "  Favorite Treats: #{dog_hash[:favorite_treats]}"
  puts ""
end

def list_dogs
  DOGS.each do |dog_hash|
    print_dog(dog_hash)
  end
end