require 'spec_helper'
describe "The CVE-2013-6459 vulnerability" do
  before(:all) do
    @check = Codesake::Dawn::Kb::CVE_2013_6459.new
    # @check.debug = true
  end
  it "fires when will_paginage 3.0.4 vulnerable version is used" do
    @check.dependencies = [{:name=>"will_paginate", :version=>'3.0.4'}]
    @check.vuln?.should == true
  end
  it "doesn't fires when will_paginage 3.0.5 safe version is used" do
    @check.dependencies = [{:name=>"will_paginate", :version=>'3.0.5'}]
    @check.vuln?.should == false
  end
end
