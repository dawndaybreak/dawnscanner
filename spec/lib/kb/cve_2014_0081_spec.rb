require 'spec_helper'
describe "The CVE-2014-0081 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2014_0081.new
		# @check.debug = true
	end
  it "affects version 3.2.16" do
    @check.dependencies = [{:name=>"rails", :version=>'3.2.16'}]
    @check.vuln?.should == true
  end
  it "affects version 4.0.0" do
    @check.dependencies = [{:name=>"rails", :version=>'4.0.0'}]
    @check.vuln?.should == true
  end
  it "affects version 4.0.2" do
    @check.dependencies = [{:name=>"rails", :version=>'4.0.2'}]
    @check.vuln?.should == true
  end
  it "affects version 4.0.1" do
    @check.dependencies = [{:name=>"rails", :version=>'4.0.1'}]
    @check.vuln?.should == true
  end

  it "affects version 3.1.x" do
    require 'securerandom'
    rand = SecureRandom.random_number(9999)
    version = "3.1.#{rand}"

    @check.dependencies = [{:name=>"rails", :version=>version}]
    @check.vuln?.should == true
  end
  
  it "affects version 3.0.x" do
    require 'securerandom'
    rand = SecureRandom.random_number(9999)
    version = "3.0.#{rand}"

    @check.dependencies = [{:name=>"rails", :version=>version}]
    @check.vuln?.should == true
  end
  it "affects version 2.x.y" do
    require 'securerandom'
    rand_min = SecureRandom.random_number(9999)
    rand_patch = SecureRandom.random_number(9999)
    version = "2.#{rand_min}.#{rand_patch}"

    @check.dependencies = [{:name=>"rails", :version=>version}]
    @check.vuln?.should == true
  end
  it "affects version 1.x.y" do
    require 'securerandom'
    rand_min = SecureRandom.random_number(9999)
    rand_patch = SecureRandom.random_number(9999)
    version = "1.#{rand_min}.#{rand_patch}"

    @check.dependencies = [{:name=>"rails", :version=>version}]
    @check.vuln?.should == true
  end

  it "doesn't affect version 4.0.3" do 
    @check.dependencies = [{:name=>"rails", :version=>'4.0.3'}]
    @check.vuln?.should == false
  end
  it "doesn't affect version 3.2.17" do 
    @check.dependencies = [{:name=>"rails", :version=>'3.2.17'}]
    @check.vuln?.should == false
  end
end
