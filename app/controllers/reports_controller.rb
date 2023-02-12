# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.all
  end

  def show
    @comments = @report.comments
    @comment = Comment.new
  end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    @report.save!
    redirect_to reports_path, notice: 'Report was successfully created.'
  end

  def update
    @report.update(report_params)
    redirect_to report_path(params[:id]), notice: 'Report was successfully updated.'
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: 'Report was successfully destroyed.'
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content).merge(user_id: current_user.id)
  end
end
