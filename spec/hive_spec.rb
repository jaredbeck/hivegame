require "spec_helper"

describe Hivegame::Hive do
  context "when initialized" do
    it("is empty") { should be_empty }
    it("has zero bugs") { subject.count.should == 0 }
  end
end

