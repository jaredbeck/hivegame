require "spec_helper"

describe Hivegame::Hive do
  context "when initialized" do
    subject { Hivegame::Hive.new }
    it("is empty") { should be_empty }
  end
end

