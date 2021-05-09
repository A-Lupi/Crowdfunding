require_relative 'spec_helper'
require_relative 'grant_project'

describe GrantProject do
  before do
    @initial_founds = 500
    @project = GrantProject.new("FGH", 1000, 500)
  end

  it "does not ever have funds removed" do
    @project.remove_fund
    @project.total_funds.should == @initial_founds
  end
end