
class Dice

  def initialize(sides)
    @dice_size = sides
    @dice_size = 6 if sides == 0
    @roll_count = 0
    @total_rolled = 0
  end
  
  def roll_count
    @roll_count
  end
  
  def total_rolled
    @total_rolled
  end
  
  def roll
    roll_dice = rand(1..@dice_size)
    puts
    puts "You rolled ---  #{roll_dice}  ---"
    puts
    @roll_count += 1
    @total_rolled += roll_dice
  end
  
  def roll_again?
    print "Would you like to roll again? (Press ENTER to roll again)"
    input = gets.chomp
    if input == ""
      true
    elsif input == "q" || input == "quit"
      false
    end
  end

end




