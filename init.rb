require 'redmine'
require 'redmine_survey/redmine_survey'

Redmine::Plugin.register :redmine_survey do
  name 'Redmine Survey plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  menu :admin_menu, :survey, { :controller => 'surveys', :action => 'index' }, :caption => 'Surveys'

  Redmine::AccessControl.map do |map|
    map.project_module :issue_tracking do |map|
      map.permission :view_surveys, {}
      map.permission :update_surveys, {}
      map.permission :delete_surveys, {}
      map.permission :create_surveys, {}
    end
  end
end