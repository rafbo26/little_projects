require_relative "dice.rb"

puts
puts "Pick the number of sides for your dice first and then roll. (Type 'q' or 'quit' to exit)"
puts
print "How many sides would you like your dice to have? "
size = gets.chomp.to_i
dice = Dice.new(size)
dice.roll

while dice.roll_again?

  dice.roll

end

puts
puts "You rolled #{dice.roll_count} times and #{dice.total_rolled} in total."
puts