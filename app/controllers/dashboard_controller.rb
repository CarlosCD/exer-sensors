class DashboardController < ApplicationController

  def index_devices
    @devices = Device.order(:created_at)
  end

  def show_device
    @device = params[:serial].present? ? Device.find_by(params[:serial_number]) : Device.find(params[:id])
    @todays_data = @device.sensor_data.order(created_at: :asc)
    if params[:time_frame].present?
      case params[:time_frame].downcase.to_sym
      when :today      then @todays_data = @todays_data.where('created_at >= ?', Time.now.beginning_of_day)
      when :this_week  then @todays_data = @todays_data.where('created_at >= ?', Time.now.beginning_of_week)
      when :this_month then @todays_data = @todays_data.where('created_at >= ?', Time.now.beginning_of_month)
      when :this_year  then @todays_data = @todays_data.where('created_at >= ?', Time.now.beginning_of_year)
      end
    end
  end

end