require "active_support/core_ext/module/delegation"
require "rgl/adjacency"
require "rgl/connected_components"

module Hivegame
  class Hive
    include Enumerable

    delegate :add_edge, :add_vertex, :remove_vertex, :to => :@bugs

    def initialize
      @bugs = RGL::AdjacencyGraph.new
    end

    # A `hive` is `connected?` if it has exactly one
    # [connected component](http://bit.ly/9DWKlC)
    def connected?
      subgraphs = 0
      @bugs.each_connected_component {|c| subgraphs += 1 }
      subgraphs == 1
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

