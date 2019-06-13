require_dependency 'issues_controller'

module RedmineSurvey
  module Patches
    module IssuesControllerPatch
      extend ActiveSupport::Concern

      included do
        alias_method_chain :update_issue_from_params, :survey
      end

      def update_issue_from_params_with_survey
        if @issue.survey.nil? && !params[:survey].nil? && Setting.plugin_redmine_survey['required']
          insert_survey(params[:survey])
        end
        update_issue_from_params_without_survey
      end

      private

      def insert_survey(survey_new)
        comentario = survey_new[:comentario]
        unless comentario.blank?
          conn = ActiveRecord::Base.connection
          query = "INSERT INTO surveys (issue_id, comentario, nota) VALUES(#{@issue.id}, '#{comentario}', #{survey_new[:nota]});"
          conn.execute query
        end
      end
    end
  end
end

unless IssuesController.included_modules.include? RedmineSurvey::Patches::IssuesControllerPatch
  IssuesController.send :include, RedmineSurvey::Patches::IssuesControllerPatch
end