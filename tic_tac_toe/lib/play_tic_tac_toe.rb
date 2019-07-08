require_relative "tic_tac_toe.rb"

game = Game.new

game.print_board

puts

until game.game_over?
  game.ask_user_for_coords
end