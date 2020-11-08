# frozen_string_literal: true

require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :discounts }
    it { should have_many(:users).conditions(role: :merchant) }
    it { should have_many(:orders).through(:items) }
  end

  describe 'instance methods' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @user = User.create(
        name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'JBob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 0
      )
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
    end
    it '#no_orders?' do
      expect(@meg.no_orders?).to eq(true)

      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17_033, user_id: @user.id)
      item_order_1 = order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, merchant_id: @meg.id)

      expect(@meg.no_orders?).to eq(false)
    end

    it '#item_count' do
      chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 30, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 22)

      expect(@meg.item_count).to eq(2)
    end

    it '#average_item_price' do
      chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 40, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 22)

      expect(@meg.average_item_price).to eq(70)
    end

    it '#distinct_cities' do
      chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 40, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 22)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17_033, user_id: @user.id)
      order_2 = Order.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17_033, user_id: @user.id)
      order_3 = Order.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17_033, user_id: @user.id)
      order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, merchant_id: @meg.id)
      order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2, merchant_id: @meg.id)
      order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, merchant_id: @meg.id)

      expect(@meg.distinct_cities).to include('Denver')
      expect(@meg.distinct_cities).to include('Hershey')
    end

    it '#pending_orders' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      user = User.create!(
        name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'J1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 0
      )
      merchant_user = bike_shop.users.create!(name: 'JakeBob',
                                              address: '124 Main St',
                                              city: 'Denver',
                                              state: 'Colorado',
                                              zip: '80202',
                                              email: 'Bob1234@hotmail.com',
                                              password: 'heftybags',
                                              password_confirmation: 'heftybags',
                                              role: 1)
      chain = bike_shop.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      tire = bike_shop.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      rack = bike_shop.items.create(name: 'Bike Rack', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Pending')
      order_item_1 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_item_2 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_item_3 = order_1.item_orders.create!(item: rack, price: rack.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_2 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Packaged')
      order_item_1 = order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2, status: 'Fulfilled', merchant_id: bike_shop.id)

      expect(bike_shop.pending_orders).to eq([order_1])
    end
    it 'disable_merchant' do
    mike = Merchant.create!(name: "Mike's Print Shop",
                            address: '123 Paper Rd.',
                            city: 'Denver',
                            state: 'CO',
                            zip: 80203)
    pull_toy = mike.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = mike.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    mike.disable_merchant
    expected = mike.items.all? {|item| item.active? == false }
    expect(expected).to eq(true)
    end

    it 'enable_merchant' do
    mike = Merchant.create!(name: "Mike's Print Shop",
                            address: '123 Paper Rd.',
                            city: 'Denver',
                            state: 'CO',
                            zip: 80203)
    pull_toy = mike.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = mike.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    mike.enable_merchant
    expected = mike.items.all? {|item| item.active? == true }
    expect(expected).to eq(true)
    end
  end
end
