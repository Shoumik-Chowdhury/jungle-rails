require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do

    before do
      @category = Category.find_or_create_by! name: 'Apparel'
    end
    
    it 'should create a new product' do
      @product = @category.products.create({
        name:  'Stained Shirt',
        quantity: 10,
        price: 24.99
      })
      expect(Product.last).to eq(@product)
    end
    
    it 'should check for presence of name' do
      @product = @category.products.create({
        name:  '',
        quantity: 10,
        price: 24.99
      })
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end

    it 'should check for presence of quantity' do
      @product = @category.products.create({
        name:  'Stained Shirt',
        quantity: nil,
        price: 24.99
      })
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end

    it 'should check for presence of price' do
      @product = @category.products.create({
        name:  'Stained Shirt',
        quantity: 10,
        price: nil
      })
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end

    it 'should check for presence of category' do
      @product = Product.create({
        name:  'Stained Shirt',
        quantity: 10,
        price: 24.99
      })
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end
end
