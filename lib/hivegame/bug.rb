module Hivegame
  class Bug
    attr_accessor :move_limit
    def color
    end
  end

  class Ant < Bug
    def initialize
      @move_limit = Float::INFINITY
    end
  end

  class Bee < Bug
    def initialize
      @move_limit = 1
    end
  end

  class Beetle < Bug
    def initialize
      @move_limit = 1
    end
  end

  class Grasshopper < Bug
    def initialize
      @move_limit = Float::INFINITY
    end
  end

  class Spider < Bug
    def initialize
      @move_limit = 3
    end
  end
end

