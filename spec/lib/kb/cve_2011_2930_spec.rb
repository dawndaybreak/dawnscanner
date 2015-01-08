require 'spec_helper'
describe "The CVE-2011-2930 vulnerability" do
  before(:all) do
    @check = Codesake::Dawn::Kb::CVE_2011_2930.new
    # @check.debug = true
  end
  it "fires when vulnerable rails version is used (2.3.12)" do
    @check.dependencies = [{:name=>"rails", :version=>'2.3.12'}]
    @check.vuln?.should   == true
  end
  it "fires when vulnerable rails version is used (3.0.9)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.0.9'}]
    @check.vuln?.should   == true
  end
  it "fires when vulnerable rails version is used (3.1.0)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.1.0'}]
    @check.vuln?.should   == true
  end
  it "doesn't fire when safe rails version is used (2.3.14)" do
    @check.dependencies = [{:name=>"rails", :version=>'2.3.14'}]
    @check.vuln?.should   == false
  end
  it "doesn't fire when safe rails version is used (3.0.10)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.0.10'}]
    @check.vuln?.should   == false
  end
  it "doesn't fire when safe rails version is used (3.1.1)" do
    @check.dependencies = [{:name=>"rails", :version=>'3.1.1'}]
    @check.vuln?.should   == false
  end
end
