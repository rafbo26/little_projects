class Game
  
  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @displayed_board = Array.new(6)
    @winning_patterns = Array.new(8)
    @game_sequence = []
    @all_sequences = []
    @players = ["X", "O"]
    @round = 0
    @moves = 0
    @stats = { "X" => 0, "O" => 0 }
    @next_move = "X"
    set_board
  end
  
  def game_over?
    false
  end
  
  def set_board
    @displayed_board[0] = "   A   B   C  "
    @displayed_board[1] = "1  #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}  "
    @displayed_board[2] = "  ----------- "
    @displayed_board[3] = "2  #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}  "
    @displayed_board[4] = "  ----------- "
    @displayed_board[5] = "3  #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}  "
    
    @winning_patterns = [[@board[0][0], @board[0][1], @board[0][2]],
                         [@board[1][0], @board[1][1], @board[1][2]],
                         [@board[2][0], @board[2][1], @board[2][2]],
                         [@board[0][0], @board[1][0], @board[2][0]],
                         [@board[0][1], @board[1][1], @board[2][1]],
                         [@board[0][2], @board[1][2], @board[2][2]],
                         [@board[0][0], @board[1][1], @board[2][2]],
                         [@board[0][2], @board[1][1], @board[2][0]]]
  end
  
  def print_board
    set_board
    puts
    @displayed_board.each { |line| puts line }
    puts
    puts "Next move: #{@next_move}"
    puts
    # @board.each { |lines| p lines }
    # puts
  end
  
  def next_move
    @next_move = @players[(@round + @moves) % 2]
  end

  def ask_user_for_coords
    print "Please write coordinates for your next move (ie. 'A1', 'B3' 'C2' etc.):  "
    coords = gets.chomp
    try_coords(coords)
  end
  
  def try_coords(coords)
    x = "abc".index(coords[0].downcase)
    y = "123".index(coords[1])
    if coords.length != 2 || x == nil || y == nil
      puts
      puts "Please use correct format for coordinates. (Pick A, B or C for column and 1, 2, 3 for row ie. 'A1' or 'B2'):  "
      puts
      ask_user_for_coords
    else
      if !@game_sequence.include?([y, x])
        update_board(y, x)
        @moves += 1
        check_win
      else
        puts
        puts "These coordinates are not empty. Try again. "
        puts
      end
    end
  end
  
  def update_board(y, x)
    @game_sequence << [y, x]
    @board[y][x] = next_move
    print_board
  end
  
  def check_win
    winner = ""
    winner = "X" if @winning_patterns.any? { |array| array.all? { |ele| ele == "X" } }
    winner = "O" if @winning_patterns.any? { |array| array.all? { |ele| ele == "O" } }
    p winner
    end_round(winner)
  end

  def end_round(winner)
    if winner == ""
      false
    else
      @stats[winner] += 1
      @board = Array.new(3) { Array.new(3, " ") }
      @displayed_board = Array.new(6)
      @winning_patterns = Array.new(8)
      @all_sequences << @game_sequence
      @game_sequence = []
      @round += 1
      @moves = 0
      puts
      puts "------------------------------------------------------"
      puts
      puts winner + " wins round -- #{@round}."
      puts
      puts "X - #{@stats["X"]} : #{@stats["O"]} - O"
      puts
      puts "------------------------------------------------------"
      puts
      ask_for_another_round
    end
  end

  def ask_for_another_round
    puts
    puts "Press ENTER to play another round or type 'quit' to finish the game. "
    puts
    input = gets.chomp
    if input == ""
      print_board
      ask_user_for_coords
    elsif input == "quit"
      # end game
    else
      ask_for_another_round
    end
  end
    
end