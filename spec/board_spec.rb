require "spec_helper"

describe Hivegame::Board do

  context "when initialized" do
    it("is empty") { should be_empty }
    it("has a count of zero") { subject.count.should == 0 }
  end

  describe "#add" do
    let(:bug) { double("Bug") }
    let(:origin) { [0,0,0] }
    it "adds a piece to the given position" do
      subject.add(origin, bug).should be_true
    end
    it "can add a piece very far away from other pieces" do
      subject.add(origin, bug).should be_true
      subject.add([-100, -100, 0], bug).should be_true
    end
    it "fails if the position is occupied" do
      subject.add(origin, bug).should be_true
      subject.add(origin, bug).should be_false
    end
    it "fails to add to a z-level with no bug underneath" do
      subject.add([0, 0, 1], bug).should be_false
    end
    it "increases the count" do
      expect { subject.add(origin, bug) }.to change { subject.count }.by(+1)
    end
  end

  describe "#neighbors" do
    it "returns eight for any point" do
      r = rand(10000)
      subject.neighbors([r,r,r]).should have(8).neighbors
    end
  end

end
