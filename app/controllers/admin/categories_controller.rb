class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  http_basic_authenticate_with :name => ENV['admin_username'], :password => ENV['admin_password']
  
  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
