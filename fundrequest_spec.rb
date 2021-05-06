require_relative 'spec_helper'
require_relative 'fundrequest'

describe Fund_request do

  before do
    $stdout = StringIO.new
    @projects = Fund_request.new("Lupi Enterprise")

    @initial_funds = 1500
    @project = Project.new("ABC", 5000, @initial_funds)
    @projects.add_project(@project)
  end


  it "adds funds if a high number is rolled " do
    allow_any_instance_of(Die).to receive(:roll).and_return(5)
    @projects.week(2)

    @project.funding.should == @initial_funds + (25*2)
  end

  it "skips the project if a medium number is rolled" do
    allow_any_instance_of(Die).to receive(:roll).and_return(3)
    @projects.week(2)

    @project.funding.should == @initial_funds
  end

  it "removes funds if a low number is rolled" do
    allow_any_instance_of(Die).to receive(:roll).and_return(1)
    @projects.week(2)

    @project.funding.should == @initial_funds - (15*2)
  end

  context "in a collection of projects" do
    before do
      @project1 = Project.new("ABC", 1000, 100)
      @project2 = Project.new("LMN", 2000, 200)
      @project3 = Project.new("XYZ", 3000, 300)

      @projects = [@project1, @project2, @project3]
    end

    it "is sorted by decreasing score" do
      @projects.sort_by {|project| -project.funding}.should == [@project3, @project2, @project1]
    end
  end


end