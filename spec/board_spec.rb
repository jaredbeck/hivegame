require "spec_helper"

describe Hivegame::Board do
  let(:origin) { [0,0,0] }

  context "when initialized" do
    it("is empty") { should be_empty }
    it("has a count of zero") { subject.count.should == 0 }
  end

  describe "#add" do
    let(:bug) { double("Bug") }
    it "adds a piece to the given position" do
      subject.add(origin, bug).should be_true
    end
    it 'raises error if point is invalid' do
      expect { subject.add([0,0,0.1], bug) }.to raise_error ArgumentError
    end
    it 'can only add bugs connected to the hive' do
      subject.add(origin, double("Bug One")).should be_true
      subject.add([2,0,0], double("Bug Two")).should be_false
      subject.should have(1).bug
      subject.add([1,0,0], double("Bug Three")).should be_true
      subject.should have(2).bugs
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

  describe "#to_ascii" do
    it "shows the correct board after a few moves" do
      subject.add [0,0,0], 'B'
      subject.add [0,1,0], 'b'
      subject.add [0,-1,0], 'A'
      subject.add [1,2,0], 'a'
      expected = <<-eod
-01:       . . . . . .
000:      . A B b . .
001:     . . . . a .
002:    . . . . . .
      eod
      subject.to_ascii.should == expected.strip
    end

    context "empty board" do
      it "should output only spaces and dots" do
        board = remove_line_nums(subject.to_ascii)
        distincts = Set.new(board.split('')).to_a
        distincts.should =~ " .".split('')
      end
    end

    it "shows bugs instead of a dot" do
      bug = 'X'
      subject.add([42,42,0], bug)
      board = remove_line_nums(subject.to_ascii)
      distincts = Set.new(board.split('')).to_a
      distincts.should =~ "X .\n".split('')
    end

    def remove_line_nums ascii_board
      ascii_board.split("\n").map{|n| n.sub(/^\d{3}\:/, '')}.join("\n")
    end
  end

  describe "#neighbors" do
    it "returns eight for any point" do
      r = rand(10000)
      subject.neighbors([r,r,r]).should have(8).neighbors
    end
  end

end
