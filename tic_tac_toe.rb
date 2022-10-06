class Player
  ENTER_NAME_MESSAGE = ' enter your name:'.freeze
  attr_accessor :player_num, :name, :letter

  def initialize(player_num, letter)
    @player_num = player_num
    @letter = letter
  end

  def gets_player_name
    puts @player_num + ENTER_NAME_MESSAGE
    @name = gets.chomp
    puts
  end
end

class Board
  OUT_OF_RANGE_ERROR_MESSAGE = 'must be a number from 1 to 9'.freeze
  SQUARE_OCCUPIED_ERROR_MESSAGE = 'This square is already occupied'.freeze
  INPUT_MESSAGE = ' enter a number from 1 to 9'.freeze
  DIVIDING_LINE = " -----------       -----------\n".freeze
  NUMBERED_BOARD_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze
  WINNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze
  attr_accessor :board_values, :is_player_one

  def initialize
    @board_values = [' '] * 9
    @is_player_one = true
  end

  def display
    DIVIDING_LINE +
      content_line(0, 1, 2) +
      DIVIDING_LINE +
      content_line(3, 4, 5) +
      DIVIDING_LINE +
      content_line(6, 7, 8) +
      DIVIDING_LINE
  end

  def error_handling(input)
    while !NUMBERED_BOARD_VALUES.include?(input) || @board_values[input - 1] != ' '
      if !NUMBERED_BOARD_VALUES.include?(input)
        puts OUT_OF_RANGE_ERROR_MESSAGE
      else
        puts SQUARE_OCCUPIED_ERROR_MESSAGE
      end
      input = gets.chomp.to_i
    end
    input
  end

  def get_position_input(player)
    puts
    puts player.name + INPUT_MESSAGE
    input = gets.chomp.to_i
    input = error_handling(input)
    @board_values[input - 1] = player.letter
  end

  def content_line(index1, index2, index3)
    "| #{NUMBERED_BOARD_VALUES[index1]} | #{NUMBERED_BOARD_VALUES[index2]} | #{NUMBERED_BOARD_VALUES[index3]} |" \
      "     | #{@board_values[index1]} | #{@board_values[index2]} | #{@board_values[index3]} |\n"
  end

  def game_loop(player1, player2)
    while @board_values.include? ' '
      get_position_input(@is_player_one ? player1 : player2)
      system 'clear'
      puts display
      @is_player_one = !@is_player_one
      return if game_logic(player1, @board_values)
    end
  end

  def game_logic(player, _board_values)
    WINNING_COMBOS.each do |index|
      if winning_line(index[0], index[1], index[2], player, @board_values)
        puts "\n#{player.name} wins"
        return true
      elsif !@board_values.include? ' '
        puts 'Draw'
        return true
      end
    end
    false
  end

  def winning_line(index1, index2, index3, player, _board_values)
    @board_values[index1] == player.letter && \
      @board_values[index2] == player.letter && \
      @board_values[index3] == player.letter
  end
end

player1 = Player.new('Player1', 'X')
player2 = Player.new('Player2', 'O')
board = Board.new

puts
player1.gets_player_name
player2.gets_player_name
system 'clear'
puts board.display
board.game_loop(player1, player2)
