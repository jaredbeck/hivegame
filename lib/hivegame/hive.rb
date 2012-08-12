require "active_support/core_ext/module/delegation"
require "rgl/adjacency"

module Hivegame
  class Hive
    include Enumerable

    delegate :add_vertex, :to => :@bugs

    def initialize
      @bugs = RGL::AdjacencyGraph.new
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

