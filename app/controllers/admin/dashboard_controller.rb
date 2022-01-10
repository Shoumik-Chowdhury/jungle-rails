class Admin::DashboardController < ApplicationController
  def show
  end

  http_basic_authenticate_with :name => ENV['admin_username'], :password => ENV['admin_password']
end
