require 'spec_helper'

describe Boss do
  before(:each) do
    @boss = Factory(:boss)
  end

  it "should be valid" do
    @boss.should be_valid
  end

  context "mass assignment" do
    it { should_not allow_mass_assignment_of(:id) }
    it { should allow_mass_assignment_of(:name) }
    it { should_not allow_mass_assignment_of(:position) }
  end

  context "associations" do
    it { should have_many(:loot_tables).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  it "should have a custom to_s" do
    @boss.to_s.should eql("#{@boss.name}")
  end
end
