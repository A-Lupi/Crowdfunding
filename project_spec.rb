require_relative 'spec_helper'
require_relative 'project'


describe Project do

    before do
      $stdout = StringIO.new
      @initial_funds = 1500
      @project = Project.new("ABC", 5000, @initial_funds)
    end

    it "has an initial goal objective" do
        @project.goal.should == 5000
    end

    it "computes the total funding outstanding as the target funding amount minus the funding amount" do
        @project.until_goal.should == 5000 - @initial_funds 
    end

    it " increases funds by 25 when funds are added " do
        @project.add_fund
        @project.funding.should == @initial_funds + 25
    end

    it " decreases funds by 15 when funds are removed " do
        @project.remove_fund
        @project.funding.should == @initial_funds - 15
    end

    context "created without a funding amount" do
      before do
        @project = Project.new("ABC", 5000)
      end

      it "has a default funding amount of 0" do
        @project.funding.should == 0
      end
    end

    context "when funding equals goal or does not" do
      before do
        @initial_funds = 5000
        @project = Project.new("ABC", 5000, @initial_funds)
      end

      it "reaches the amount of funding or exceeds the goal" do
        @project.funding.should == @project.goal
      end
    end

    context "when funding is equal or less than 0" do
      before do
        @initial_funds = 0
        @project = Project.new("ABC", 5000, @initial_funds)
      end

      it "does not reaches the total funding outstanding or equal to zero" do
        @project.funding.should == 0 
      end
    end

    it "computes pledges money as the sum of all pledge money" do

      @project.pledges.should == 0

      @project.received_pledge(Pledge.new(:bronze, 50))

      @project.pledges.should == 50

      @project.received_pledge(Pledge.new(:silver, 75))

      @project.pledges.should == 125

      @project.received_pledge(Pledge.new(:gold, 100))

      @project.pledges.should == 225
    end

    it "computes total funds as the sum of a projects funding and pledges" do
      @project.received_pledge(Pledge.new(:bronze, 50))
      @project.received_pledge(Pledge.new(:bronze, 50))
    
      @project.total_funds.should == 1600
    end

  it "yields each found treasure and its total points" do
    @project.received_pledge(Pledge.new(:gold, 100))
    @project.received_pledge(Pledge.new(:gold, 100))
    @project.received_pledge(Pledge.new(:silver, 75))
    @project.received_pledge(Pledge.new(:silver, 75))
    @project.received_pledge(Pledge.new(:silver, 75))
    @project.received_pledge(Pledge.new(:bronze, 50))
    @project.received_pledge(Pledge.new(:bronze, 50))
    @project.received_pledge(Pledge.new(:bronze, 50))
    @project.received_pledge(Pledge.new(:bronze, 50))

    yielded = []
    @project.each_received_pledge do |pledge|
      yielded << pledge
    end

    yielded.should == [
      Pledge.new(:gold, 200),
      Pledge.new(:silver, 225),
      Pledge.new(:bronze, 200)
    ]
  end

end