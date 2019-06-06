require_dependency 'issues_controller'

module RedmineSurvey
  module Patches
    module IssuesControllerPatch
      extend ActiveSupport::Concern

      included do
        alias_method_chain :update_issue_from_params, :survey
      end

      def update_issue_from_params_with_survey
        update_issue_from_params_without_survey
        puts '================================================ update_with_survey  ================================================'
        @issue.update_survey(params[:survey])
      end
    end
  end
end

unless IssuesController.included_modules.include? RedmineSurvey::Patches::IssuesControllerPatch
  IssuesController.send :include, RedmineSurvey::Patches::IssuesControllerPatch
end