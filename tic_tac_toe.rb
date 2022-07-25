# frozen_string_literal: true

class Game
  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]

  attr_reader :player_one, :player_two, :p1_marker, :p2_marker

  def initialize
    puts 'Please Enter Name for Player 1'
    @p1_name = gets.chomp
    puts 'Please Enter a Marker (letter or number) for Player 1'
    @p1_marker = (puts 'Please input a single character' until gets.chomp.match(/^\w$/))
    puts 'Would you like to play against another player, or the computer?'
    puts "Press 'p' for player, or press 'c' for computer"
    @human_or_ai = (puts "Press 'p' for player, or press 'c' for computer" until gets.chomp.match(/^[pc]$/))
    puts 'Please Enter Name for Player 2'
    @p2_name = gets.chomp
    puts 'Please Enter a Marker (letter or number) for Player 2'
    @p2_marker = (puts 'Please input a single character' until gets.chomp.match(/^\w$/))
    puts @p2_marker
  end

  def create_players
    @player_one = HumanPlayer.new(@p1_name, @p1_marker, 'p')
    @player_two = if @human_or_ai == 'p'
                    HumanPlayer.new(@p2_name, @p2_marker, 'p')
                  else
                    ComputerPlayer.new(@p2_name, @p2_marker, 'c')
                  end
  end

  def change_current_player
    # Code
  end

  def check_for_winner
    # Code
  end

  def end_game
    # Code
  end
end

class Player
  def initialize(name, marker, is_ai)
    @name = name
    @marker = marker
    @is_ai = is_ai == 'c'
  end

  def claim_square(square)
    board.assign_square(square, self) unless board.is_claimed?(square)
  end
end

class HumanPlayer < Player
  # Code
end

class ComputerPlayer < Player
  def select_random_square
    rand_num = rand(9)
    if board.is_claimed?(rand_num)
      select_random_square
    else
      claim_square(rand_num, self)
    end
  end
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
game.create_players
p game.player_one
p game.player_two
p game.p1_marker
p game.p2_marker

board = Board.new
board.display_board_keys
board.display_current_board
