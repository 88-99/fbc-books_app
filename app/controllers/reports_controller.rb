# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.order(:id).page(params[:page]).per(5)
  end

  def show
    @comments = @report.comments
    @comment = Comment.new
  end

  def new
    @report = Report.new
  end

  def edit
    correct_user(@report) and return
  end

  def create
    @report = current_user.reports.new(report_params)
    @report.save!
    redirect_to reports_path, notice: t('controllers.common.notice_create', name: Report.model_name.human)
  end

  def update
    correct_user(@report) and return
    @report.update(report_params)
    redirect_to report_path(params[:id]), notice: t('controllers.common.notice_update', name: Report.model_name.human)
  end

  def destroy
    correct_user(@report) and return
    @report.destroy
    redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
