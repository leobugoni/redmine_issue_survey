class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :find_issue, only: [:new, :create]

  def show
    # @survey = Survey.find(params[:id])
  end

  def index
    @surveys = Survey.order("id").page(params['page']).per(20)
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.issue_id = @issue.id
    @survey.save
    # redirect_to surveys_path(@survey)
  end

  def destroy
    @survey.destroy
    redirect_to surveys_path
  end

  def update
  end

  private

    def find_issue
      @issue = Issue.find(1)
    end

    def set_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:comentario, :nota, :issue)
    end

end
