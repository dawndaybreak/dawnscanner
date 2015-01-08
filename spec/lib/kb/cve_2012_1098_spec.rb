require 'spec_helper'
describe "The CVE-2012-1098 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2012_1098.new
		# @check.debug = true
	end
  it "fires when vulnerable rails version it has been found (3.0.11)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.0.11'}]
    @check.vuln?.should   == true
  end
  it "fires when vulnerable rails version it has been found (3.1.3)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.1.3'}]
    @check.vuln?.should   == true
  end
  it "fires when vulnerable rails version it has been found (3.2.1)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.2.1'}]
    @check.vuln?.should   == true
  end
  it "doesn't fire when non vulnerable rails version it has been found (3.2.2)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.2.2'}]
    @check.vuln?.should   == false
  end
  it "doesn't fire when non vulnerable rails version it has been found (3.2.4)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.2.4'}]
    @check.vuln?.should   == false
  end
  it "doesn't fire when non vulnerable rails version it has been found (3.1.4)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.1.4'}]
    # @check.debug = true
    @check.vuln?.should   == false
  end
  it "doesn't fire when rails version older than 3.x.y it has been found" do
    @check.dependencies = [{:name=>"rails", :version=>'2.3.12'}]
    @check.vuln?.should   == false
  end
end
