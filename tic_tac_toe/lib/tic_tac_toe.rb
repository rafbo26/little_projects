class Game
  
  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @displayed_board = Array.new(6)
    @winning_patterns = Array.new(8)
    set_board
    @game_sequence = []
    @players = ["X", "O"]
    @round = 0
    @stats = { "X" => 0, "O" => 0 }
  end
  
  def game_over?
    check_win
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
    @board.each { |lines| p lines }
    puts
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
        @round += 1
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
    @board[y][x] = @players[@round % 2]
    print_board

  end
  
  def check_win
    if @winning_patterns.any? { |array| array.all? { |ele| ele == "X" } }
      @stats["X"] += 1
      true
    elsif @winning_patterns.any? { |array| array.all? { |ele| ele == "O" } }
      @stats["O"] += 1
      true
    end
  end
end