require 'cvss'

module Codesake
  module Dawn
    module Core
      module Kb
        module BasicCheck

          include Codesake::Dawn::Debug

          attr_reader :name
          attr_reader :cvss
          attr_reader :cwe
          attr_reader :owasp
          attr_reader :release_date
          attr_reader :applies
          attr_reader :kind
          attr_reader :message
          attr_reader :remediation
          attr_reader :aux_links
          attr_reader :mitigated

          # This is the ruby version used by the target application. set in
          # Engine class around line #107
          attr_accessor :ruby_version

          # This is an array of ruby versions that lead a parcitular version to
          # be exploitable.
          # In example, consider CVE-2013-1655, the Puppet rubygem version
          # vulnerability can be exploited only if ruby version is 1.9.3 or
          # higher
          attr_reader :ruby_vulnerable_versions

          # The framework target version
          attr_reader   :target_version
          # The versions of the framework that fixes the vulnerability
          attr_reader   :fixes_version

          # Vulnerability evidences
          attr_reader   :evidences

          # Check status. Returns the latest vuln? call result
          attr_reader   :status

          # Put the check in debug mode
          attr_accessor :debug

          # This is a flag for the security check family. Valid values are:
          #   + generic_check
          #   + code_quality
          #   + cve_bulletin
          #   + code_style
          #   + owasp_ror_cheatsheet
          #   + owasp_top_10_n (where n is a number between 1 and 10)
          attr_accessor :check_family
          ALLOWED_FAMILIES = [:generic_check, :code_quality, :cve_bulletin, :code_style, :owasp_ror_cheatsheet, :owasp_top_10_1, :owasp_top_10_2, :owasp_top_10_3, :owasp_top_10_4, :owasp_top_10_5, :owasp_top_10_6, :owasp_top_10_7, :owasp_top_10_8, :owasp_top_10_9, :owasp_top_10_10]

          # This is the check severity level. It tells how dangerous is the
          # vulnerability for you application.
          #
          # Valid values are:
          #   + :critical
          #   + :high
          #   + :medium
          #   + :low
          #   + :info
          #   + :none
          attr_accessor :severity

          # This is the check priority level. It tells how fast you should
          # mitigate the vulnerability.
          #
          # Valid values are:
          #   + :critical
          #   + :high
          #   + :medium
          #   + :low
          #   + :info
          #   + :none
          attr_accessor :priority

          def initialize(options={})
            @applies                  = []
            @ruby_version             = ""
            @ruby_vulnerable_versions = []

            @name         = options[:name]
            @cvss         = options[:cvss]
            @cwe          = options[:cwe]
            @owasp        = options[:owasp]
            @release_date = options[:release_date]
            @applies      = options[:applies] unless options[:applies].nil?
            @kind         = options[:kind]
            @message      = options[:message]
            @remediation  = options[:mitigation]
            @aux_links    = options[:aux_links]

            @target_version = options[:target_version]
            @fixes_version  = options[:fixes_version]
            @ruby_version   = options[:ruby_version]

            @evidences    = []
            @evidences    = options[:evidences] unless options[:evidences].nil?
            @mitigated    = false
            @status       = false
            @debug        = false
            @severity     = :none
            @priority     = :none
            @check_family = :generic_check

            @severity         = options[:severity] unless options[:severity].nil?
            @priority         = options[:priority] unless options[:priority].nil?
            @check_family     = options[:check_family] unless options[:check_family].nil?

            # FIXME.20140325
            #
            # I don't want to manually fix 150+ ruby files to add something I can
            # deal here
            @check_family = :cve if !options[:name].nil? && options[:name].start_with?('CVE-')

            if $logger.nil?
              require 'codesake-commons'
              $logger  = Codesake::Commons::Logging.instance
              $logger.helo "dawn-basic-check", Codesake::Dawn::VERSION
            end
          end

          def self.families
            return ALLOWED_FAMILIES.map { |x| x.to_s }
          end

          def family=(item)
            if ! ALLOWED_FAMILIES.find_index(item.to_sym).nil?
              instance_variable_set(:@check_family, item.to_sym)
              return item
            else
              $logger.err("invalid check family: #{item}")
              instance_variable_set(:@check_family, :generic_check)
              return @family
            end
          end

          def family
            return "CVE bulletin"                   if @check_family == :cve
            return "Ruby coding style"              if @check_family == :code_style
            return "Ruby code quality check"        if @check_family == :code_quality
            return "Owasp Ruby on Rails cheatsheet" if @check_family == :owasp_ror_cheatsheet
            return "Owasp Top 10"                   if @check_family.to_s.start_with?('owasp_top_10')
            return "Unknown"
          end

          def priority
            return (@priority == :none)? "unknown" : @priority.to_s
          end
          def severity
            return @severity.to_s unless @severity == :none

            # if not set and if cvss is available, than use CVSS
            unless self.cvss.nil?

              score = Cvss::Engine.new.score(self.cvss)
              case score
              when 10
                return "critical"
              when 7..9
                return "high"
              when 4..6
                return "medium"
              when 2..3
                return "low"
              when 0..1
                return "info"
              else 
                return "unknown"
              end
            else
              return "unknown"
            end

            # if not set, no cvss available just return unknown
            return "unknown"
          end

          def applies_to?(name)
            ! @applies.find_index(name).nil?
          end
          def cve_link
            "http://cve.mitre.org/cgi-bin/cvename.cgi?name=#{@name}"
          end
          def nvd_link
            "http://web.nvd.nist.gov/view/vuln/detail?vulnId=#{@name}"
          end
          def rubysec_advisories_link
            "http://www.rubysec.com/advisories/#{@name}/"
          end

          def cvss_score
            return Cvss::Engine.new.score(self.cvss) unless self.cvss.nil?
            "    "
          end

          def mitigated?
            self.mitigated
          end

        end
      end
    end
  end
end
