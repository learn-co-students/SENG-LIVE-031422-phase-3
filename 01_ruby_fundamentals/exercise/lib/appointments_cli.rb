APPOINTMENTS = []

def start_cli
  puts "Hi! Welcome to the Appointments CLI"
  main_menu
 
  loop do 
    handle_user_choice(ask_for_choice)
    main_menu
  end
end

def main_menu
  puts "Here's what you can do:".cyan
  puts "  1. Add Appointment".cyan
  puts "  2. List Appointments".cyan
  puts "  exit".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def ask_for_choice
  print "What would you like to do? "
  choice = gets.chomp
  if choice == "exit"
    exit
  else
    choice
  end
end

def handle_user_choice(choice)
  if choice == "1"
    add_appointment
  elsif choice == "2"
    list_appointments
  elsif choice == "debug"
    binding.pry
  elsif choice == "men"
    puts "Thank you for using the appointments CLI"
    exit
  else
    puts "Whoops! Sorry, I didn't understand that choice".red
  end
end

def add_appointment
  appointment = {}
  print "What time does the appointment start? "
  appointment[:time] = gets.chomp
  print "What doctor is the appointment with? "
  appointment[:doctor] = gets.chomp
  print "What is the purpose of your visit? "
  appointment[:purpose] = gets.chomp
  APPOINTMENTS << appointment
  print_appointment(appointment)
end

def print_appointment(appointment)
  puts ""
  puts appointment[:time].light_green
  puts "  Doctor: #{appointment[:doctor]}"
  puts "  Purpose: #{appointment[:purpose]}"
  puts ""
end

def list_appointments
  puts "All Appointments"
  APPOINTMENTS.each {|appt| print_appointment(appt)}
end