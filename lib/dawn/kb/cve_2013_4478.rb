module Dawn
		module Kb
			# Automatically created with rake on 2013-12-17
			class CVE_2013_4478
				include DependencyCheck

				def initialize
          message = "Sup before 0.13.2.1 and 0.14.x before 0.14.1.1 allows remote attackers to execute arbitrary commands via shell metacharacters in the filename of an email attachment."
          super({
            :name=>'CVE-2013-4478', 
            :cvss=>"AV:N/AC:M/Au:N/C:P/I:P/A:P",  
            :release_date => Date.new(2013, 12, 7),
            :cwe=>"94", 
            :owasp=>"A9",
            :applies=>["rails", "padrino", "sinatra"],
            :kind => Dawn::KnowledgeBase::DEPENDENCY_CHECK,
            :message => message,
            :mitigation=>"Please upgrade sup rubygem",
            :aux_links => ["http://www.openwall.com/lists/oss-security/2013/10/30/2"]
          })
          self.safe_dependencies = [{:name=>"sup", :version=>['0.13.2.1', '0.14.1.1']}]

				end
			end
		end
end
