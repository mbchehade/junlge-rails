require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'

        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
    end

    scenario "They see all products" do

      visit root_path

      find('a.btn.btn-default').click
      # commented out b/c it's for debugging only

      page.has_content?('Description')
      puts page.html
      save_and_open_screenshot
    end
end