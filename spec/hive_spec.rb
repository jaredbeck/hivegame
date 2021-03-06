require "spec_helper"

describe Hivegame::Hive do
  context "when initialized" do
    it("is empty") { should be_empty }
    it("has zero bugs") { subject.count.should == 0 }
  end

  describe "#connected?" do
    context "given two vertices and no edges" do
      it "is not connected" do
        subject.add_vertex double "Bug"
        subject.add_vertex double "Bug"
        subject.should_not be_connected
      end
    end
  end

  describe "#add_vertex" do
    it "should no longer be empty" do
      subject.add_vertex double "Bug"
      should_not be_empty
    end
  end
end

