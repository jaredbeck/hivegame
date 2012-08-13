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

  describe "#add" do
    it "adds a piece to the given position" do
      subject.add(5,5,1, double("Bug")).should be_true
    end
    it "fails if the position is occupied" do
      subject.add(5,5,1, double("Bug")).should be_true
      subject.add(5,5,1, double("Bug")).should be_false
    end
    it "fails if its adding to a z-level with no bug underneath" do
      subject.add(5,5,2, double("Bug")).should be_false
    end
    it "can add to a z-level if a bug is underneath and the bug is a beetle.  Cuz shyeah" 
    it "increases the count"
  end

end
