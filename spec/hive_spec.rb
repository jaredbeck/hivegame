require "spec_helper"

describe Hivegame::Hive do
  context "when initialized" do
    it("is empty") { should be_empty }
    it("has zero bugs") { subject.count.should == 0 }
    it("has a nil head") { subject.head.should be_nil }
  end
  describe "#head=" do
    it "should change the head of the bug graph" do
      bug = double "Bug"
      expect { subject.head = bug }.to \
        change { subject.head }.to(bug)
    end
  end
end

