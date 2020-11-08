# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
10.times do
  Merchant.create(
                  name: Faker::Name.name,
                  address: Faker::Address.street_address,
                  city: Faker::Address.city,
                  state: Faker::Address.state,
                  zip: Faker::Address.zip,
                )
end
# bike_shop = Merchant.create(name: "Someone's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
# dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
# meg_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
# cat_shop = Merchant.create(name: "Brian's Cat Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
# mouse_shop = Merchant.create(name: "Brian's Mouse Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
# giraffe_shop = Merchant.create(name: "Brian's Giraffe Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
# hippo_shop = Merchant.create(name: "Brian's Hippo Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
# penguin_shop = Merchant.create(name: "Brian's Penguin Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#users
jake = User.create!(name: 'Jake',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'jake@admin.com',
  password: 'admin',
  password_confirmation: 'admin',
  role: 2
)
john = bike_shop.users.create!(name: 'john',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'bike@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
greg = dog_shop.users.create!(name: 'greg',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'dog@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
garrett = meg_shop.users.create!(name: 'garrett',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'meg@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
molly = cat_shop.users.create!(name: 'molly',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'cat@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
erica = mouse_shop.users.create!(name: 'erica',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'mouse@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
tom = giraffe_shop.users.create!(name: 'tom',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'giraffe@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
anne = hippo_shop.users.create!(name: 'anne',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'hippo@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
pete = penguin_shop.users.create!(name: 'pete',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'penguin@merchant.com',
  password: 'merchant',
  password_confirmation: 'merchant',
  role: 1
)
steve = User.create!(name: 'steve',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'steve@user.com',
  password: 'user',
  password_confirmation: 'user',
  role: 0
)
claire = User.create!(name: 'claire',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'claire@user.com',
  password: 'user',
  password_confirmation: 'user',
  role: 0
)
raul = User.create!(name: 'raul',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'raul@user.com',
  password: 'user',
  password_confirmation: 'user',
  role: 0
)
mike = User.create!(name: 'mike',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'mike@user.com',
  password: 'user',
  password_confirmation: 'user',
  role: 0
)
ranjit = User.create!(name: 'ranjit',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'ranjit@user.com',
  password: 'user',
  password_confirmation: 'user',
  role: 0
)

#items
tire1 = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 912)
tire2 = meg_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 912)
pen = meg_shop.items.create!(name: "Ball", description: "They'll write!", price: 10, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 93)
ball = meg_shop.items.create!(name: "Round", description: "They'll never pop!", price: 9, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 95)
straw = penguin_shop.items.create!(name: "Long", description: "They'll suck pop!", price: 8, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 92)
eraser = penguin_shop.items.create!(name: "Rubber", description: "They'll never write!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
stick = penguin_shop.items.create!(name: "wood", description: "They'll never grow!", price: 4, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 93)
toothpick = meg_shop.items.create!(name: "plastic", description: "They'll never pop!", price: 4, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 94)
trash = cat_shop.items.create!(name: "banana", description: "They'll never pop!", price: 5, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 955)
wrapper = giraffe_shop.items.create!(name: "gum", description: "They'll never pop!", price: 6, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 96)
film1 = mouse_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
film2 = mouse_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
film3 = hippo_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
film4 = hippo_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 932)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 921)

#orders
order1 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: steve.id, status: "Pending")
order2 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: claire.id, status: "Packaged")
order3 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: raul.id, status: "Packaged")
order4 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: mike.id, status: "Shipped")
order5 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: ranjit.id, status: "Cancelled")

#item_orders
order1.item_orders.create!(item_id: tire1.id, price: tire1.price, quantity: 10, status: "Pending", merchant_id: bike_shop.id)
order1.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9, status: "Fulfilled", merchant_id: meg_shop.id)
order1.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8, status: "Fulfilled", merchant_id: meg_shop.id)
order1.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7, status: "Pending", merchant_id: penguin_shop.id)

order2.item_orders.create!(item_id: eraser.id, price: eraser.price, quantity: 6, status: "Fulfilled", merchant_id: penguin_shop.id)
order2.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 5, status: "Fulfilled", merchant_id: penguin_shop.id)
order2.item_orders.create!(item_id: toothpick.id, price: toothpick.price, quantity: 4, status: "Fulfilled", merchant_id: meg_shop.id)

order3.item_orders.create!(item_id: trash.id, price: trash.price, quantity: 3, status: "Fulfilled", merchant_id: cat_shop.id)
order3.item_orders.create!(item_id: wrapper.id, price: wrapper.price, quantity: 2, status: "Fulfilled", merchant_id: giraffe_shop.id)
order3.item_orders.create!(item_id: film2.id, price: film2.price, quantity: 1, status: "Fulfilled", merchant_id: mouse_shop.id)
order3.item_orders.create!(item_id: film3.id, price: film3.price, quantity: 1, status: "Fulfilled", merchant_id: hippo_shop.id)

order4.item_orders.create!(item_id: tire2.id, price: tire2.price, quantity: 10, status: "Fulfilled", merchant_id: meg_shop.id)
order4.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9, status: "Fulfilled", merchant_id: meg_shop.id)

order5.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8, status: "Unfulfilled", merchant_id: meg_shop.id)
order5.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7, status: "Unfulfilled", merchant_id: penguin_shop.id)
order5.item_orders.create!(item_id: film4.id, price: film4.price, quantity: 7, status: "Unfulfilled", merchant_id: hippo_shop.id)
order5.item_orders.create!(item_id: dog_bone.id, price: dog_bone.price, quantity: 7, status: "Unfulfilled", merchant_id: dog_shop.id)
