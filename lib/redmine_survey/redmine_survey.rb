require 'redmine_survey/hooks/views_issues_hook'
require 'redmine_survey/hooks/model_issue_hook'

Rails.configuration.to_prepare do
  require 'redmine_survey/patches/issue_patch'
  require 'redmine_survey/patches/issues_controller_patch'
end

module RedmineSurvey

  def self.settings()
    Setting[:plugin_redmine_issue_checklist].blank? ? {} : Setting[:plugin_redmine_issue_checklist]
  end

end

