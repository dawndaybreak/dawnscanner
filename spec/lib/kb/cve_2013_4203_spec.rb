require 'spec_helper'
describe "The CVE-2013-4203 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2013_4203.new
		# @check.debug = true
	end
  it "is reported when a vulnerable rgpg version is detected (0.2.2)" do
    @check.dependencies = [{:name=>"rgpg", :version=>"0.2.2"}]
    @check.vuln?.should   == true
  end
  it "is not reported when a safe rgpg version is detected (0.2.3)" do
    @check.dependencies = [{:name=>"rgpg", :version=>"0.2.3"}]
    @check.vuln?.should   == false
  end
end
