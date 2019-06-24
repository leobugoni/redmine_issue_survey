require 'redmine'
require 'redmine_survey/redmine_survey'

Redmine::Plugin.register :redmine_survey do
  name 'Redmine Survey plugin'
  author 'Leonardo Bugoni'
  description 'This satisfaction survey plugin for Redmine'
  version '0.1.0'
  url 'https://github.com/leobugoni/redmine_issue_survey'
  author_url 'mailto:leobugoni@gmail.com'

  menu :admin_menu, :survey, { :controller => 'surveys', :action => 'index' }, { :last => true, :caption => "Pequisa de Satisfação", :html => { :class => 'icon-ticket-note' } }

  settings :partial => 'settings/survey_settings'
  Redmine::AccessControl.map do |map|
    map.project_module :issue_tracking do |map|
      map.permission :view_surveys, {}
    end
  end
end
