require_relative 'three_dimensional'

module Hivegame

  # A Hive board is a three-dimensional matrix of hexagonal cells,
  # which are identified by a 3-tuple of coordinates.
  class Board
    include ThreeDimensional

    # A board enumerates bugs in play
    include Enumerable

    ORIGIN = [0,0,0]

    # To conserve memory, the internal representation of the
    # `@board` is a hash mapping coordinates to bugs.  An
    # array would be mostly empty, wasting memory.  We also
    # maintain an undirected graph, '@hive', because graphs excel
    # at answering certain questions.
    def initialize
      @board = {}
      @hive = Hive.new
    end

    # `add` a bug to the board, with no concern over whose turn
    # it is, or whether it is placed next to an opponent's bug.
    # The `Board` is, however, responsible for certain fundamentals
    # like the One Hive Rule.
    def add(point, bug)
      validate_point(point)
      return false unless supported_point?(point)
      return false if requires_climbing?(point) && !bug.climber?
      return false if occupied?(point)
      return false if !empty? && neighbor_bugs(point).empty?
      add_to_hive(point, bug)
      @board[point] = bug
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
          line << ' '
          line << (@board[[row,col,0]] || '.').to_s
        end

        lines << line
      end

      lines.join "\n"
    end

    # `each` enumerates bugs in play
    def each
      bugs.each { |b| yield b }
    end

    def empty?
      count == 0
    end

    # On a three-dimensional hex grid, each hex has eight
    # neighbors, including the hexes above and below.
    def neighbor_points point
      validate_point(point)
      row, col, height = point[0], point[1], point[2]
      offsets = [[-1,-1,0], [-1,0,0], [0,-1,0], [0,1,0], [1,0,0], \
        [1,1,0], [0,0,1], [0,0,-1]]
      offsets.map do |r,c,h|
        [row+r, col+c, height+h]
      end
    end

    def bugs
      @board.values
    end

    def neighbor_bugs point
      @board.values_at(*neighbor_points(point)).compact
    end

    private

    def add_to_hive point, bug
      @hive.add_vertex(bug)

      unless empty?
        neighbor_bugs(point).each do |n|
          @hive.add_edge(n, bug)
        end
        fail unless @hive.connected?
      end

      return true
    end

    def col_count
      max_col - min_col
    end

    def col_numbers
      @board.map{|point, bug| point[1]}
    end

    def requires_climbing? point
      point[2] > 0
    end

    # `supported_point?` returns true if `point` is resting on
    # the table or if the hex below `point` is occupied.
    def supported_point? point
      r,c,h = point[0], point[1], point[2]
      h == 0 || occupied?([r,c,h-1])
    end

    def min_row
      empty? ? -1 : row_numbers.min - 1
    end

    def max_row
      empty? ? 1 : row_numbers.max + 1
    end

    def min_col
      empty? ? -1 : col_numbers.min - 1
    end

    def max_col
      empty? ? 1 : col_numbers.max + 1
    end

    def occupied? point
      !@board[point].nil?
    end

    def row_numbers
      @board.map{|point, bug| point[0]}
    end

  end
end
