# frozen_string_literal: true

# Module to initiate gameplay
module Begin
  def begin_game
    game = Game.new
    game.create_players
    game.process_play
  end
end

# Main Class with most game-driving logic
class Game
  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ]
  ROW_DIVIDER = '---+---+---'

  attr_reader :board_values, :players, :current_player

  include Begin

  def initialize
    puts ' '
    puts 'Would you like to play against another player, or the computer?'
    puts "Press 'p' for player, or press 'c' for computer"
    @human_or_ai = gets.chomp
    @players = []
    @board_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @game_over = false
    @game_status = 'playing'
  end

  def create_players
    player_one = HumanPlayer.new(self)
    @players << player_one
    player_two = @human_or_ai == 'p' ? HumanPlayer.new(self) : ComputerPlayer.new(self)
    @players << player_two
    @current_player = @players[rand(2)]
  end

  def player_won?(player)
    WINNING_COMBOS.any? do |combo|
      combo.all? { |square| @board_values[square] == player.marker }
    end
  end

  def game_draw?
    board_full? && !player_won?(@current_player)
  end

  def process_play
    until @game_over
      if game_draw?
        @game_status = 'draw'
        @game_over = true
        process_end_game
      elsif player_won?(@current_player)
        @game_status = 'won'
        @game_over = true
        @game_winner = @current_player
        process_end_game
      else
        wipe_screen
        @current_player = current_player == players[0] ? players[1] : players[0]
        @current_player.claim_square
      end
    end
  end

  def process_end_game
    wipe_screen
    display_current_board
    if @game_status == 'draw'
      puts "It's a DRAW"
    else
      puts "#{@game_winner.name} WON!"
    end
    puts 'Would you like to play again?'
    puts "Press 'y' for YES or press 'n' for NO"
    play_again = gets.chomp
    if play_again == 'y'
      # Play again code
      wipe_screen
      @players[0].reset_count
      begin_game
    end
  end

  # Board Methods
  def square_claimed?(square)
    board_values[square] != ' '
  end

  def assign_square(square, player)
    board_values[square] = player.marker
    process_play
    # player_won?(player)
  end

  def board_empty?
    @board_values.all? { |square| square == ' ' }
  end

  def board_full?
    @board_values.none? { |square| square == ' ' }
  end

  def display_current_board
    puts <<-HEREDOC

      KEY:
       0 | 1 | 2
      #{ROW_DIVIDER}
       3 | 4 | 5
      #{ROW_DIVIDER}
       6 | 7 | 8

       #{@board_values[0]} | #{@board_values[1]} | #{@board_values[2]}
      #{ROW_DIVIDER}
       #{@board_values[3]} | #{@board_values[4]} | #{@board_values[5]}
      #{ROW_DIVIDER}
       #{@board_values[6]} | #{@board_values[7]} | #{@board_values[8]}

    HEREDOC
  end

  def wipe_screen
    puts "\e[H\e[2J"
  end
end

# Player Superclass
class Player
  attr_accessor :player_count
  attr_reader :marker, :name

  @@player_count = 0

  def initialize(game)
    puts "Please Enter Name for Player #{@@player_count + 1}"
    @name = gets.chomp
    puts "Please Enter a Marker (letter or number) for Player #{@@player_count + 1}"
    @marker = gets.chomp[0]
    @is_ai = false
    @game = game
    @@player_count += 1
    @game.wipe_screen
  end

  def claim_square
    @game.display_current_board
    puts "#{@name}, please select the square you would like to take (0-8)"
    square = gets.chomp.to_i
    # @game.assign_square(square, self) unless @game.square_claimed?(square)
    if @game.square_claimed?(square)
      @game.wipe_screen
      claim_square
    else
      @game.assign_square(square, self)
    end
  end

  def reset_count
    @@player_count = 0
  end
end

# Human Player Subclass
class HumanPlayer < Player; end

# Computer Player Subclass - Can select random square
class ComputerPlayer < Player
  def initialize(game)
    super
    @is_ai = true
    @game = game
  end

  def claim_square
    rand_num = rand(9)
    if @game.square_claimed?(rand_num)
      claim_square
    else
      # puts "#{@name} selects square #{rand_num}"
      @game.assign_square(rand_num, self)
    end
  end
end

# Initiate Game
game = Game.new
game.create_players
game.process_play
