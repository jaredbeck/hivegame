module Hivegame

  class Hex
    attr_accessor :bug
    def initialize()
      @bug = nil
    end

    def occupied?
      return !@bug.nil?
    end
  end

  # A Hive board is a three-dimensional matrix of hexagonal cells,
  # which are identified by a 3-tuple of coordinates.
  class Board

    # A board can enumerate *occupied* hexes
    include Enumerable

    ORIGIN = [0,0,0]

    # To conserve memory, the internal representation of the
    # `@board` is a hash mapping coordinates to hexes.  An
    # array would be mostly empty, wasting memory.  We also
    # maintain an undirected graph, '@hive', because graphs excel
    # at answering certain questions.
    def initialize
      @board = {ORIGIN => Hex.new}
      @hive = Hive.new
    end

    def add(point, bug)
      return ArgumentError unless point.is_a? Array
      return false unless supported_point?(point)
      return false if hex(point).occupied?
      return false unless add_to_hive_if_connected(point, bug)
      @board[point].bug = bug
      return true
    end

    def add_to_hive_if_connected point, bug
      @hive.add_vertex(bug)

      unless empty?
        occupied_neighbor_hexes(point).each do |n|
          @hive.add_edge(n.bug, bug)
        end
        unless @hive.connected?
          @hive.remove_vertex(bug)
          return false
        end
      end

      return true
    end

    # `to_ascii` returns a textual representation of the board
    def to_ascii
      lines = []
      cols = col_count
      min_row.upto(max_row) do |row|
        line = "%03d:" % row # left-padded row number
        (cols - row).times {line << ' '}

        min_col.upto(max_col) do |col|
          line << (hex([row,col,0]).bug || '.').to_s
          line << ' '
        end

        lines << line
      end

      lines.join "\n"
    end

    # `each` enumerates occupied hexes
    def each
      occupied_hexes.each { |hex| yield hex }
    end

    def empty?
      count == 0
    end

    # `hex` returns the hex at the specified `point`,
    # creating a hex if none exists.
    def hex point
      return ArgumentError unless point.is_a? Array
      @board[point] = Hex.new if @board[point].nil?
      @board[point]
    end

    def neighbors point
      return ArgumentError unless point.is_a? Array
      row, col, height = point[0], point[1], point[2]
      offsets = [[-1,-1,0], [-1,0,0], [0,-1,0], [0,1,0], [1,0,0], \
        [1,1,0], [0,0,1], [0,0,-1]]
      offsets.map do |r,c,h|
        [row+r, col+c, height+h]
      end
    end

    def occupied_hexes
      return @board.select { |point, hex| hex.occupied? }
    end

    def occupied_neighbor_hexes point
      neighbors(point).map{|n| hex(n)}.select{|n| n.occupied?}
    end

    private

    def col_count
      max_col - min_col
    end

    def col_numbers
      @board.map{|k,v| k[1]}
    end

    # `supported_point?` returns true if `point` is resting on
    # the table or if the hex below `point` is occupied.
    def supported_point? point
      r,c,h = point[0], point[1], point[2]
      h == 0 || hex([r,c,h-1]).occupied?
    end

    def min_row
      row_numbers.min
    end

    def max_row
      row_numbers.max
    end

    def min_col
      col_numbers.min
    end

    def max_col
      col_numbers.max
    end

    def row_numbers
      @board.map{|k,v| k[0]}
    end

  end
end
