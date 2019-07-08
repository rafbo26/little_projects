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
    @winner = ""
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

  def strings(name)
    str = { "next_move"    => "Please write coordinates for your next move (ie. 'A1', 'B3' 'C2' etc.):  ",
            "wrong_coords" => "\nPlease use correct format for coordinates. (Pick A, B or C for column and 1, 2, 3 for row ie. 'A1' or 'B2'): \n",
            "taken_coords" => "\nThese coordinates are not empty. Try again. \n",
            "next_round"   => "Press ENTER to play another round or type 'quit' to finish the game. ",
            "current_move" => "\nNext move: #{@next_move} \n\n",
            "breaker"      => "\n------------------------------------------------------ \n\n",
            "winner"       => "--- #{@winner} --- wins round --- #{@round} --- \n\n",
            "stats"        => "        X - #{@stats["X"]} : #{@stats["O"]} - O"
            }
    str[name]
  end
  
  def print_board
    set_board
    puts
    @displayed_board.each { |line| puts line }
    puts strings("current_move")
    # @board.each { |lines| p lines }
  end
  
  def next_move
    @next_move = @players[(@round + @moves) % 2]
  end

  def ask_user_for_coords
    print strings("next_move")
    coords = gets.chomp
    try_coords(coords)
  end
  
  def try_coords(coords)
    if coords.length != 2
      puts strings("wrong_coords")
      ask_user_for_coords
    else
      x = "abc".index(coords[0].downcase)
      y = "123".index(coords[1])
      if !@game_sequence.include?([y, x])
        update_board(y, x)
        check_win
      else
        puts strings("taken_coords")
      end
    end
  end
  
  def update_board(y, x)
    @game_sequence << [y, x]
    @board[y][x] = @next_move
    @moves += 1
    next_move
    print_board
  end
  
  def check_win
    @winner = "X" if @winning_patterns.any? { |array| array.all? { |ele| ele == "X" } }
    @winner = "O" if @winning_patterns.any? { |array| array.all? { |ele| ele == "O" } }
    end_round
  end

  def end_round
    if @winner == ""
      false
    else
      @stats[@winner] += 1
      @board = Array.new(3) { Array.new(3, " ") }
      @displayed_board = Array.new(6)
      @winning_patterns = Array.new(8)
      @all_sequences << @game_sequence
      @game_sequence = []
      @round += 1
      @moves = 0
      puts strings("breaker")
      puts strings("winner")
      puts strings("stats")
      puts strings("breaker")
      @winner = ""
      ask_for_another_round
    end
  end

  def ask_for_another_round
    puts
    puts strings("next_round")
    puts
    input = gets.chomp
    if input == ""
      print_board
      ask_user_for_coords
    elsif input == "quit"
      return
    else
      ask_for_another_round
    end
  end
  
end