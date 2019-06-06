require_dependency 'issue'

module RedmineSurvey
  module Patches

    module IssuePatch

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :copy_from, :survey
          has_one :survey, class_name: 'Survey'
        end

      end

      module InstanceMethods

        def copy_from_with_survey(arg, options={})
          copy_from_without_survey(arg, options)
          issue = arg.is_a?(Issue) ? arg : Issue.visible.find(arg)
          self.survey = issue.survey.map { |cl| cl.dup }
          self
        end

        # def update_survey(survey_new)
        #   puts survey_new[:comentario]
        #   puts survey_new[:nota]
        #   puts '================================================================= update_survey ================================================================='
        #   Survey.new(comentario: survey_new[:comentario], nota: survey_new[:nota])
        # end


        def update_survey(surveys, create_journal = false)
          surveys ||= []

          old_surveys = survey.collect(&:info).join(', ')

          survey.destroy_all
          survey << surveys.uniq.collect do |cli|
            Survey.new(comentario: cli[:comentario], nota: cli[:nota], issue_id: cli[:issue_id])
          end
          puts 'ENTROU AQUI ===================='
          puts survey
          puts 'PASSOU AQUI ===================='

          new_surveys = survey.collect(&:info).join(', ')

          if current_journal && create_journal && (new_surveys != old_surveys)
            current_journal.details << JournalDetail.new(
              property:  'attr',
              prop_key:  'survey',
              old_value: old_surveys,
              value: new_surveys)
          end
        end
      end
    end
  end
end

unless Issue.included_modules.include?(RedmineSurvey::Patches::IssuePatch)
  Issue.send(:include, RedmineSurvey::Patches::IssuePatch)
end