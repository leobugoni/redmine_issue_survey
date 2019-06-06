module RedmineSurvey
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener
      render_on :view_issues_form_details_bottom, partial: 'issues/form_survey'
    end
  end
end
