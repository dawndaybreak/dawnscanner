require 'spec_helper'
describe "The CVE-2013-0263 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2013_0263.new
		# @check.debug = true
	end
  it "is not reported when rack version 1.4.5 is used" do
    @check.dependencies = [{:name=>"rack", :version=>'1.4.5'}]
    @check.vuln?.should == false
  end
end
