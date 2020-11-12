require 'rails_helper'

describe "As an admin, when I visit the merchant index page" do
  it "I click on a merchant's name, I'm directed to the admin merchant show page" do
    user = User.create(
      name: 'JakeBob',
      address: '124 Main St',
      city: 'Denver',
      state: 'Colorado',
      zip: '80202',
      email: 'JBob1234@hotmail.com',
      password: 'heftybags',
      password_confirmation: 'heftybags',
      role: 2
    )
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    item = bike_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 932)

    visit "/login"

    fill_in :email, with: "JBob1234@hotmail.com"
    fill_in :password, with: "heftybags"
    click_button "Login"

    visit "/merchants"

    click_on "#{bike_shop.name}"
    expect(current_path).to eq("/admin/merchants/#{bike_shop.id}")
    expect(page)
    expect(page).to have_link(bike_shop.name)
    expect(page).to have_link("All #{bike_shop.name} Items")
    expect(page).to have_link("Update Merchant")
    expect(page).to have_content("Number of Items: #{bike_shop.item_count}")
    expect(page).to have_content("Average Price of Items: $#{bike_shop.average_item_price}")
    expect(page).to have_content("Cities that order these items:")
  end
end

describe "As an admin when I visit the admin's merchant index page" do
  describe "I see a 'disable' button next to any merchants who are not yet disabled" do
    it "When I click on the 'disable button, I am returned to the admin's merchant
        index page where I see the merchant account is disabled and flash message" do
      jake = User.create!(name: 'JakeBob',
                          address: '124 Main St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '80202',
                          email: 'JBob1234@hotmail.com',
                          password: 'heftybags',
                          password_confirmation: 'heftybags',
                          role: 2)
      @mike = Merchant.create!(name: "Mike's Print Shop",
                              address: '123 Paper Rd.',
                              city: 'Denver',
                              state: 'CO',
                              zip: 80203)
      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"
      visit "/admin/merchants"
      expect(page).to have_button("Disable")

      within("#merchant-#{mike.id}") do
        click_button "Disable"
      end

      expect(page).to have_content("Merchant Account Is Now Disabled")
    end
  end
end

describe  "As an admin, when I visit the merchant index page"  do
  describe "And I click on the 'disable' button for an enabled merchant" do
    it "Then all of that merchant's items should be deactivated" do
      jake = User.create!(name: 'JakeBob',
                          address: '124 Main St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '80202',
                          email: 'JBob1234@hotmail.com',
                          password: 'heftybags',
                          password_confirmation: 'heftybags',
                          role: 2)
      mike = Merchant.create!(name: "Mike's Print Shop",
                              address: '123 Paper Rd.',
                              city: 'Denver',
                              state: 'CO',
                              zip: 80203)
      pull_toy = mike.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = mike.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"
      visit "/admin/merchants"

      within("#merchant-#{@mike.id}") do
        click_button "Disable"
      end

      expected = mike.items.all? {|item| item.active? == false }
      expect(expected).to eq(true)
    end
  end
end

describe "As an admin when I visit the merchant index page" do
  describe "I see an 'enable' button next to any merchants whose accounts are disabled" do
    it "I am returned to the index page and merchant is enabled and I see a flash message
        and all merchant's items are now active" do
      jake = User.create!(name: 'JakeBob',
                          address: '124 Main St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '80202',
                          email: 'JBob1234@hotmail.com',
                          password: 'heftybags',
                          password_confirmation: 'heftybags',
                          role: 2)
      mike = Merchant.create!(name: "Mike's Print Shop",
                              address: '123 Paper Rd.',
                              city: 'Denver',
                              state: 'CO',
                              zip: 80203)
      pull_toy = mike.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = mike.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/admin/merchants"
      within("#merchant-#{mike.id}") do
        click_button "Disable"
        click_button "Enable"
      end

      expected = mike.items.all? {|item| item.active? == true }
      expect(expected).to eq(true)
      expect(page).to have_content("Merchant Account Is Now Enabled")
    end
  end


 describe "As an admin user, when I visit the merchant's index page at '/admin/merchants'" do
   describe "I see all merchants and next to each merchant's name I see their city and state" do
     it "Merchant's name is a link to their dashboard" do
       jake = User.create!(name: 'JakeBob',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.com',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 2)
       mike = Merchant.create!(name: "Mike's Print Shop",
                               address: '123 Paper Rd.',
                               city: 'Denver',
                               state: 'CO',
                               zip: 80203)
       steve = Merchant.create!(name: "Steve's Print Shop",
                               address: '123 Steve Rd.',
                               city: 'Denver',
                               state: 'CO',
                               zip: 80203)
       pull_toy = mike.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
       dog_bone = steve.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

       visit "/login"

       fill_in :email, with: "JBob1234@hotmail.com"
       fill_in :password, with: "heftybags"
       click_button "Login"

       visit "/admin/merchants"

       within("#merchant-#{mike.id}") do
         expect(page).to have_content(mike.city)
         expect(page).to have_content(mike.state)

         expect(page).to have_link(mike.name)

         expect(page).not_to have_button("Enable")
         expect(page).to have_button("Disable")
       end

       click_on "#{mike.name}"
       expect(current_path).to eq("/admin/merchants")
     end
   end
  end
end
