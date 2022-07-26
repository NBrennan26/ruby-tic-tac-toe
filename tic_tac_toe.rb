# frozen_string_literal: true

# Main Class with most game-driving logic
class Game
  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]
  ROW_DIVIDER = '---+---+---'

  attr_reader :players, :human_or_ai, :board

  def initialize
    puts 'Would you like to play against another player, or the computer?'
    puts "Press 'p' for player, or press 'c' for computer"
    @human_or_ai = gets.chomp
    @players = []
    @board_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def create_players
    player_one = HumanPlayer.new
    @players << player_one
    player_two = @human_or_ai == 'p' ? HumanPlayer.new : ComputerPlayer.new
    @players << player_two
    @current_player = @players[rand(2)]
  end

  def current_player
    puts @current_player
    @current_player
  end

  def player_won?(player)
    WINNING_COMBOS.any? do |combo|
      combo.all? { |square| @board_values[square] == player.marker }
    end
  end

  # Board Methods
  def square_claimed?(square)
    board_values[square] != ' '
  end

  def assign_square(square, player)
    board_values[square] = player.marker
  end

  def board_empty?
    @board_values.all? { |square| square == ' ' }
  end

  def board_full?
    @board_values.none? { |square| square == ' ' }
  end

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

       #{@board_values[0]} | #{@board_values[1]} | #{@board_values[2]}
      #{ROW_DIVIDER}
       #{@board_values[3]} | #{@board_values[4]} | #{@board_values[5]}
      #{ROW_DIVIDER}
       #{@board_values[6]} | #{@board_values[7]} | #{@board_values[8]}

    HEREDOC
  end
end

# Player Superclass
class Player
  @@player_count = 0
  def initialize
    puts "Please Enter Name for Player #{@@player_count + 1}"
    @name = gets.chomp
    puts "Please Enter a Marker (letter or number) for Player #{@@player_count + 1}"
    @marker = gets.chomp[0]
    @is_ai = false
    @@player_count += 1
  end

  def claim_square(square)

  end

  # def claim_square(board, square)
  #   board.assign_square(square, self) unless board.is_claimed?(square)
  # end

  def give_info
    puts "Player Name - #{@name}"
    puts "Player Marker - #{@marker}"
    puts "Player is AI - #{@is_ai}"
  end
end

# Human Player Subclass
class HumanPlayer < Player
  # Code
end

# Computer Player Subclass - Can select random square
class ComputerPlayer < Player
  def initialize
    super
    @is_ai = true
  end
end

game = Game.new
game.create_players
p game.players

game.display_board_keys
game.display_current_board
game.current_player

game.board_empty?
game.board_full?

# game.access_players.each do |player|
#   p player.give_info
#   player.claim_square(game.board, 3)
# end

# board.display_current_board

########
#######
######
#####

# Ask for square selection
# Change Turn/current player
# Player gets square
# Square is already taken
# AI picks random square
# Check for winner (combos)
# Check for draw (board empty, no winner)
# End game
# Ask for reset/new game

# def change_current_player
# def check_for_winner
# def end_game

# def select_random_square(board)
#   rand_num = rand(9)
#   if board.is_claimed?(rand_num)
#     select_random_square
#   else
#     claim_square(board, rand_num)
#   end
# end

# Game win logic
# given board_values and WINNING COMBOS
# If the board values at WINNING COMBOS are all either players marker, they win
# for each |combo| in WINNING_COMBOS
  # for each |value| in combo
    # if @board_values[value]
  #board_values[]

#  WINNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
#  @board_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

# def player_won?(player)
# winning_combos.any? do |combo|
# combo.all? { |square| @board_values[sqaure] == player.marker } 