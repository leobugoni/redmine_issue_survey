require_dependency 'issue'

module RedmineSurvey
  module Patches

    module IssuePatch

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :copy_from, :survey
          has_one :survey, class_name: Survey
        end

      end

      module InstanceMethods
        def copy_from_with_survey(arg, options={})
          copy_from_without_survey(arg, options)
          issue = arg.is_a?(Issue) ? arg : Issue.visible.find(arg)
          self.survey = issue.survey.map { |cl| cl.dup }
          self
        end
      end
    end
  end
end

unless Issue.included_modules.include?(RedmineSurvey::Patches::IssuePatch)
  Issue.send(:include, RedmineSurvey::Patches::IssuePatch)
end