class Admin::DashboardController < ApplicationController
  def show
    @products = Product.count
    @categories = Category.count
  end

  http_basic_authenticate_with :name => ENV['admin_username'], :password => ENV['admin_password']
end
