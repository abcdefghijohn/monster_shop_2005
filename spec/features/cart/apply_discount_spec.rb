require 'rails_helper'

RSpec.describe 'Cart apply discount' do
  describe 'When I have sufficient number of items' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @mike.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 30)
      @pencil = @meg.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 10, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      user = User.create(name: 'JakeBob',
                               address: '124 Main St',
                               city: 'Denver',
                               state: 'Colorado',
                               zip: '80202',
                               email: 'JBob1234@hotmail.com',
                               password: 'heftybags',
                               password_confirmation: 'heftybags',
                               role: 0)
      @discount_1 = @mike.discounts.create(discount_percent: 20, min_quantity: 5)
      @discount_2 = @mike.discounts.create(discount_percent: 50, min_quantity: 10)
      @discount_3 = @meg.discounts.create(discount_percent: 30, min_quantity: 10)

      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'

      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      visit '/cart'

    end
    it 'I will have a discounted total' do
      within "#cart-item-#{@paper.id}" do
        4.times do
          click_on('+')
        end
      end
      within "#cart-item-#{@pencil.id}" do
        9.times do
          click_on('+')
        end
      end
      expect(page).to have_content(150)
    end

    it 'I will receive the larger discount' do
      within "#cart-item-#{@paper.id}" do
        9.times do
          click_on('+')
        end
      end
      within "#cart-item-#{@pencil.id}" do
        9.times do
          click_on('+')
        end
      end
      expect(page).to have_content(170)
    end
  end
end
