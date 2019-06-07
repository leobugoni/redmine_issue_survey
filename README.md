# Redmine Issue Survey

This plugin enables you to add surveys to a issue. 

## Compatibility

This plugin version is compatible only with Redmine 3.0 and later.

## Installation

1. To install the plugin
    * Download the .ZIP archive, extract files and copy the plugin directory into #{REDMINE_ROOT}/plugins.
    
    Or

    * Change you current directory to your Redmine root directory:  

            cd {REDMINE_ROOT}
            
      Copy the plugin from GitHub using the following commands:
      
            git clone git@gitlab.com:maxicredito/redmine_issue_survey.git
            
2. Update the Gemfile.lock file by running the following commands:  

        bundle install
            
3. This plugin requires a migration. Run the following command to upgrade your database (make a database backup before):  

        bundle exec rake redmine:plugins:migrate RAILS_ENV=production 
        
4. Restart Redmine.
