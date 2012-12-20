module Hivegame
  module ThreeDimensional
    def validate_point p
      if !p.is_a?(Array) || p.length != 3 || p.detect {|i| !i.is_a?(Integer)}
        raise ArgumentError, 'Invalid point: Expected array of 3 integers'
      end
    end
  end
end

