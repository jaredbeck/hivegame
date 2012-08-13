module Hivegame

  class Hex
  end

  class Board
   def initialize(rows=20, cols=20)
     @rows, @cols = rows, cols
     @board = Array.new(@rows) do |row|
       Array.new(@cols) do |col|
         Hex.new
       end
     end
   end

   # This will print the board out to the console
   def draw
     @rows.times do |row|
       line = ''
       line << "#{row}:"
       (@cols - row).times {line << ' '}

       @cols.times do |col|
         line << (distance([4,4], [row,col]) || 'X').to_s
         line << ' '
       end

       puts line
     end
   end

   def empty?
     true
   end


   def [](row)
     @board[row]
   end
 end
end

