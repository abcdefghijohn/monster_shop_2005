require 'rails_helper'

RSpec.describe 'Merchant Discount New' do
  describe 'When I visit the merchant discount new page' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @shifter = @meg.items.create(name: 'Shimano Shifters', description: "It'll always shift!", active?: false, price: 180, image: 'https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg', inventory: 2)
      @discount_1 = @meg.discounts.create(discount_percent: 5, min_quantity: 5)
      @discount_2 = @meg.discounts.create(discount_percent: 10, min_quantity: 10)

      user = @meg.users.create(name: 'JakeBob',
                               address: '124 Main St',
                               city: 'Denver',
                               state: 'Colorado',
                               zip: '80202',
                               email: 'JBob1234@hotmail.com',
                               password: 'heftybags',
                               password_confirmation: 'heftybags',
                               role: 1)

      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'
    end

    it 'I see a link to create a new discount' do
      click_on("My Discounts")
      expect(page).to have_link("Create New Discount")
      click_on("Create New Discount")

      fill_in :discount_percent, with: 20
      fill_in :min_quantity, with: 20
      click_on("Submit")

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_content("Discount Percentage: 20%")
      expect(page).to have_content("Minimum Quantity: 20 items")
      expect(page).to have_content("Discount has been created.")
    end
  end
end
