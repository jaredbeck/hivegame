require "rgl/adjacency"

module Hivegame
  class Hive
    include Enumerable

    def initialize
      @bugs = RGL::AdjacencyGraph.new
    end

    def add_vertex v
      @bugs.add_vertex v
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

