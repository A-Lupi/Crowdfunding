require_relative 'spec_helper'
require_relative 'pledge_trove'

describe Pledge do

  before do
    @pledge = Pledge.new(:bronze, 50)
  end

  it "has a name attribute" do
    @pledge.category.should == :bronze
  end

  it "has a value attribute" do
    @pledge.value.should == 50
  end

end

describe PledgeTrove do
    it "has 3 types of pledges" do
      PledgeTrove::PLEDGES.size.should == 3
    end

    it "has bronze pledge" do
      PledgeTrove::PLEDGES[0].should == Pledge.new(:bronze, 50)
    end

    it "has silver pledge" do
      PledgeTrove::PLEDGES[1].should == Pledge.new(:silver, 75)
    end

    it "has gold pledge" do
      PledgeTrove::PLEDGES[2].should == Pledge.new(:gold, 100)
    end
    
    it "returns a random badge" do
      pledge = PledgeTrove.random

      PledgeTrove::PLEDGES.should include(pledge)
    end

end