module Dawn
		module Kb

      class CVE_2013_6461_a
        include DependencyCheck

        def initialize
          message = "Vulnerability arises when Nokogiri version 1.6.0 and 1.5.x (x<11) is used"
          super({
            :name=>"CVE_2013_6461_a",
            :kind=>Dawn::KnowledgeBase::DEPENDENCY_CHECK,
          })
          self.safe_dependencies = [{:name=>"nokogiri", :version=>['1.6.1', '1.5.11']}]
        end

      end

      class CVE_2013_6461_b
        include RubyVersionCheck
        def initialize
          message = "Vulnerability arises when Nokogiri version 1.6.0 and 1.5.x (x<11) is used with JRuby"
          super({
            :name=>"CVE_2013_6461_b",
            :kind=>Dawn::KnowledgeBase::RUBY_VERSION_CHECK,
          })
          self.safe_rubies = [ {:engine=>"jruby", :version=>"99.99.99", :patchlevel=>"p999"}]
        end
      end

			class CVE_2013_6461
        include ComboCheck

				def initialize
          message = "There is an entity expansion vulnerability in Nokogiri when using JRuby. Nokogiri users on JRuby using the native Java extension.  Attackers can send
XML documents with carefully crafted entity expansion strings which can cause the server to run out of memory and crash."
          super({
            :name=>"CVE-2013-6461",
            :cvss=>"AV:N/AC:M/Au:N/C:N/I:N/A:P",
            :release_date => Date.new(2013, 12, 15),
            :cwe=>"",
            :owasp=>"A9", 
            :applies=>["rails", "sinatra", "padrino"],
            :kind=>Dawn::KnowledgeBase::COMBO_CHECK,
            :message=>message,
            :mitigation=>"Please upgrade nokogiri gem to a newer version",
            :aux_links=>["https://groups.google.com/forum/#!topic/ruby-security-ann/DeJpjTAg1FA"],
            :checks=>[CVE_2013_6461_a.new, CVE_2013_6461_b.new]
          })





				end
			end
		end
