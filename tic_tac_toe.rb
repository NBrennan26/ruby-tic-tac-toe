# frozen_string_literal: true

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

  def access_players
    @players
  end

  # Board Methods
  def square_claimed?(square)
    board_values[square] != ' '
  end

  def assign_square(square, player)
    board_values[square] = player.marker
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

  # def claim_square(board, square)
  #   board.assign_square(square, self) unless board.is_claimed?(square)
  # end

  def give_info
    puts "Player Name - #{@name}"
    puts "Player Marker - #{@marker}"
    puts "Player is AI - #{@is_ai}"
  end
end

class HumanPlayer < Player
  # Code
end

class ComputerPlayer < Player
  def initialize
    super
    @is_ai = true
  end

  # def select_random_square(board)
  #   rand_num = rand(9)
  #   if board.is_claimed?(rand_num)
  #     select_random_square
  #   else
  #     claim_square(board, rand_num)
  #   end
  # end
end

game = Game.new
game.create_players
p game.players

game.display_board_keys
game.display_current_board

# game.access_players.each do |player|
#   p player.give_info
#   player.claim_square(game.board, 3)
# end

# board.display_current_board
