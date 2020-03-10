require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
    product = Product.create(description: "text", image: "string") 
    it "checks name is required" do
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it "checks price is required" do
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    it "checks quantity is required" do
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "checks category is required" do
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end