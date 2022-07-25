# frozen_string_literal: true

class Game
  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]

  def initialize
    puts 'Please Enter Name for Player 1'
    @p1_name = gets.chomp
    puts 'Please Enter a Marker (letter or number) for Player 1'
    @p1_marker = gets.chomp
    puts 'Would you like to play against another player, or the computer?'
    puts "Press 'p' for player, or press 'c' for computer"
    @human_or_ai = (puts "Press 'p' for player, or press 'c' for computer" until gets.chomp.match(/^[pc]/))
    puts 'Please Enter Name for Player 2'
    @p2_name = gets.chomp
    puts 'Please Enter a Marker (letter or number) for Player 2'
    @p2_marker = gets.chomp
  end
end

class Player
  def initialize(name)
    @name = name
  end

  def claim_square(square)
    board.assign_square(square, self) unless board.is_claimed?(square)
  end
end

class HumanPlayer < Player
  # Code
end

class ComputerPlayer < Player
  # Code
end

class Board
  attr_reader :board_values

  ROW_DIVIDER = '---+---+---'

  def initialize
    @board_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def is_claimed?(square)
    board_values[square] != ' '
  end

  def assign_square(square, player)
    board_values[square] = player.marker
  end

  # rubocop:disable Metrics/AbcSize
  def display_board_keys
    puts <<-HEREDOC

       0 | 1 | 2
      #{ROW_DIVIDER}
       3 | 4 | 5
      #{ROW_DIVIDER}
       6 | 7 | 8

    HEREDOC
  end

  def display_current_board
    puts <<-HEREDOC

       #{board_values[0]} | #{board_values[1]} | #{board_values[2]}
      #{ROW_DIVIDER}
       #{board_values[3]} | #{board_values[4]} | #{board_values[5]}
      #{ROW_DIVIDER}
       #{board_values[6]} | #{board_values[7]} | #{board_values[8]}

    HEREDOC
  end
  # rubocop:enable Metrics/AbcSize
end

game = Game.new

board = Board.new
board.display_board_keys
board.display_current_board
