require 'rails_helper'

RSpec.describe 'Delete discount' do
  describe "When I got to the discount index page and click on the 'Delete Discount' button"  do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @mike.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 30)

      user = @mike.users.create(name: 'JakeBob',
                               address: '124 Main St',
                               city: 'Denver',
                               state: 'Colorado',
                               zip: '80202',
                               email: 'JBob1234@hotmail.com',
                               password: 'heftybags',
                               password_confirmation: 'heftybags',
                               role: 1)
      @discount_1 = @mike.discounts.create(discount_percent: 20, min_quantity: 5)
      @discount_2 = @mike.discounts.create(discount_percent: 50, min_quantity: 10)

      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'
      click_on("My Discounts")

    end
    it "I can edit then click 'Delete Discount' and I am redirected to the discount index
        and no longer see the discount" do
      within "#discount-#{@discount_2.id}" do
      click_button("Delete Discount")

      @discount_2.reload
      expect(page).not_to have_content(@discount_2.discount_percent)
      expect(page).not_to have_content(@discount_2.min_quantity)
    end
    end
  end
end
