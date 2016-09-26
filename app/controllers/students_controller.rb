class StudentsController < ApplicationController
  protect_from_forgery
  require 'json'

  def index
    result = Net::HTTP.get(URI.parse('https://crystal-pepsi.herokuapp.com/students'))
    @students = JSON.parse(result)
  end

  def show
    @student = Student.new
    @metrics = {}
    if params[:id]
      @student.name = params[:id]
      result = Net::HTTP.get(URI.parse('https://crystal-pepsi.herokuapp.com/students/'+ params[:id] + '/meetings'))

      @schedule = JSON.parse(result)
      calculate_metrics
      @metrics

    end

  end

  def calculate_metrics
    all_mins = 0.0
    instr_mins = 0
    @schedule.each do |m|
      if m["tags"].include?("instructional")
        instr_mins += m["duration"]
      end
      all_mins += m["duration"]
    end
    value = instr_mins/all_mins
    @metrics["Percentage of time spent in instructional courses"] = "#{(value * 100).round}%"
  end
end
