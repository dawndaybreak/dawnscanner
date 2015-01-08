module Dawn
		module Kb
			# Automatically created with rake on 2013-05-06
			class CVE_2012_2661
				include DependencyCheck

				def initialize
          message = "The Active Record component in Ruby on Rails 3.0.x before 3.0.13, 3.1.x before 3.1.5, and 3.2.x before 3.2.4 does not properly implement the passing of request data to a where method in an ActiveRecord class, which allows remote attackers to conduct certain SQL injection attacks via nested query parameters that leverage unintended recursion, a related issue to CVE-2012-2695."

          super({
            :name=>"CVE-2012-2661",
            :cvss=>"AV:N/AC:L/Au:N/C:P/I:N/A:N",
            :release_date => Date.new(2012, 6, 22),
            :cwe=>"",
            :owasp=>"A9", 
            :applies=>["rails"],
            :kind=>Dawn::KnowledgeBase::DEPENDENCY_CHECK,
            :message=>message,
            :mitigation=>"Please upgrade rails version at least to 3.2.5, 3.1.5 or 3.0.13. As a general rule, using the latest stable rails version is recommended.",
            :aux_links=>["https://groups.google.com/d/topic/rubyonrails-security/dUaiOOGWL1k/discussion"]
          })

          self.safe_dependencies = [{:name=>"rails", :version=>['3.0.13', '3.2.5', '3.1.5']}]
				end
			end
		end
