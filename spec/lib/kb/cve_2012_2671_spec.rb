require 'spec_helper'
describe "The CVE-2012-2671 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2012_2671.new
		# @check.debug = true
	end
  it "is reported when ruby-cache version 0.5 is used" do
    @check.dependencies = [{:name=>"rack-cache", :version=>'0.5'}]
    @check.vuln?.should == true
  end
  it "is reported when ruby-cache version 0.8 is used" do
    @check.dependencies = [{:name=>"rack-cache", :version=>'0.8'}]
    @check.vuln?.should == true
  end
  it "is reported when ruby-cache version 1.1.1 is used" do
    @check.dependencies = [{:name=>"rack-cache", :version=>'1.1.1'}]
    @check.vuln?.should == true
  end
  it "is not reported when ruby-cache version 1.1.2 is used" do
    @check.dependencies = [{:name=>"rack-cache", :version=>'1.1.2'}]
    @check.vuln?.should == false
  end
end
