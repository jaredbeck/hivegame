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

   def add(r,c,h, bug)
     if @board[r][c]
       return false
     
     @board[r][c].bug = bug
   end


   # This will print the board out to the console
   def draw
     @rows.times do |row|
       line = "%03d:" % row
       (@cols - row).times {line << ' '}

       @cols.times do |col|
         line << '. '
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

