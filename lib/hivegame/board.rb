

module Hivegame 

 class Hex
   
 end
    
 class Board
   def initialize(rows=9, cols=9)
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

   def neighbors(row, col)
     [[-1,-1],[-1,0],[0,-1],[0,1],[1,0],[1,1]].map do |r, c|
       [row+r, col+c]
     end
   end

   def [](row)
     @board[row]
   end
 end 
end
