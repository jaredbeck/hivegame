# qb queen bee
# ant
# beetle
# grasshopper
# spider

require "spec_helper"

describe Hivegame::Bug do
  it "responds to color" do
    should respond_to :color
  end
end

describe Hivegame::Ant do
  its(:move_limit) { should == Float::INFINITY }
end

describe Hivegame::Bee do
  its(:move_limit) { should == 1 }
end

describe Hivegame::Beetle do
  its(:move_limit) { should == 1 }
end

describe Hivegame::Grasshopper do
  its(:move_limit) { should == Float::INFINITY }
end

describe Hivegame::Spider do
  its(:move_limit) { should == 3 }
end

