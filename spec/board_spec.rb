require "spec_helper"

describe Hivegame::Board do

  context "when initialized" do
    it("is empty") { should be_empty }
  end

  describe "#neighbors" do
    it "returns eight for any point" do
      r = rand(10000)
      subject.neighbors([r,r,r]).should have(8).neighbors
    end
  end

  describe "#add" do
    it "adds a piece to the given position" do
      subject.add([5,5,1], double("Bug")).should be_true
    end
    it "can add a piece very far away from other pieces" do
      subject.add([100, 100, 1], double("Bug")).should be_true
      subject.add([-100, -100, 1], double("Bug")).should be_true
    end
    it "fails if the position is occupied" do
      subject.add([5,5,1], double("Bug")).should be_true
      subject.add([5,5,1], double("Bug")).should be_false
    end
    it "fails to add to a z-level with no bug underneath" do
      subject.add([5,5,2], double("Bug")).should be_false
    end
    it "can add to a z-level if a bug is underneath and the bug is a beetle"
    it "increases the count"
  end

end
