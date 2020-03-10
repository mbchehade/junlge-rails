require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "They see an item in their cart" do

    visit root_path

    find('button.btn.btn-primary').click
    # commented out b/c it's for debugging only

    page.has_content?('My Cart (1)')
    save_and_open_screenshot
    puts page.html
  end
end