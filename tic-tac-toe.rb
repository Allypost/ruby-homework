class Board
  def initialize
    @board = Array.new(9) { |i| i }
    @player = 'O'
  end

  def do_move
    puts "Player '#{@player}' move."
    print "Where do you want to put your `#{@player}` [0-8]? "
    move = gets.chomp.to_i

    return false unless move.between?(0, 8)
    return false unless @board[move].is_a?(Numeric)

    @board[move] = @player
    @player = next_player

    [move, next_player]
  end

  def next_player
    if @player == 'O'
      'X'
    else
      'O'
    end
  end

  def draw
    @board.each_slice(3) do |row|
      puts "[#{row.join('] [')}]"
    end
  end
end

board = Board.new

loop do
  board.draw
  move, player = board.do_move

  if move
    puts "Set '#{player}' to field #{move}"
  else
    puts 'That field is already occupied! Try again.'
  end

  puts ''
end