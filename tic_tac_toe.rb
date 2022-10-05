class Player
  attr_accessor :name, :letter

  def initialize(name, letter)
    @name = name
    @letter = letter
  end
end

class Board
  attr_accessor :board_values

  def initialize
    @board_values = [" "] * 9
  end
end

game_board = Board.new
player1 = Player.new("player1", "x")
player2 = Player.new("player2", "O")

def player_pick(player, game_board_values)
  puts
  puts "#{player.name} pick a number square"
  square = gets.chomp
  puts
  game_board_values[square.to_i - 1] = player.letter
  board game_board_values
end

def board(game_board_values)
  dividing_line = ' -----------'

  puts dividing_line
  content_line 0, 1, 2, game_board_values
  puts dividing_line
  content_line 3, 4, 5, game_board_values
  puts dividing_line
  content_line 6, 7, 8, game_board_values
  puts dividing_line
end

def content_line(index1, index2, index3, game_board_values)
  puts "| #{game_board_values[index1]} | #{game_board_values[index2]} | #{game_board_values[index3]} |"
end

puts ' -----------'
puts "| 1 | 2 | 3 |"
puts ' -----------'
puts "| 4 | 5 | 6 |"
puts ' -----------'
puts "| 7 | 8 | 9 |"
puts ' -----------'

def game_logic(player, game_board_values)
  winning_indexes = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  winning_indexes.each do |index|
    if winning_line(index[0], index[1], index[2], player, game_board_values)
      puts "\n#{player.name} wins"
      return true
    elsif !game_board_values.include? " "
      puts "Draw"
      return true
    end
  end
  false
end

def winning_line(index1, index2, index3, player, game_board_values)
  game_board_values[index1] == player.letter && game_board_values[index2] == player.letter && game_board_values[index3] == player.letter
end

while game_board.board_values.include? " "
  player_pick player1, game_board.board_values
  return if game_logic player1, game_board.board_values

  player_pick player2, game_board.board_values
  return if game_logic player2, game_board.board_values
end
