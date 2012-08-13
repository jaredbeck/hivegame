require "spec_helper"

describe Hivegame::Board do

  context "when initialized on a 10x10 grid" do
    it("is empty") { should be_empty }
  end 

  describe "#neighbors" do
    it "shows six neighbors for a middle point" do
      subject.neighbors(5,5).should have(6).neighbors
    end
  end 
end
