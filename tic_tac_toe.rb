# frozen_string_literal: true

board_square_values = []
9.times { board_square_values.push('.') }

rows_arr = [
  " #{board_square_values[0]} | #{board_square_values[1]} | #{board_square_values[2]} ",
  '---+---+---',
  " #{board_square_values[3]} | #{board_square_values[4]} | #{board_square_values[5]} ",
  '---+---+---',
  " #{board_square_values[6]} | #{board_square_values[7]} | #{board_square_values[8]} "
]
rows_arr.each do |row|
  p row
end
