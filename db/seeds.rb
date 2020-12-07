Hotel.create!(name: "パーティードレス", address: "パーティー、結婚式",
phone_number: Faker::PhoneNumber.cell_phone, pool: true, parking: true, gender: false, skin_color: 2, hair_color: 3)
Hotel.create!(name: "ドレス", address: "デート、結婚式",
phone_number: Faker::PhoneNumber.cell_phone, pool: true, parking: true, gender: false, skin_color: 1, hair_color: 2)

20.times do |i|
  Hotel.create!(name: ["ドレス#{i+1}","スーツ#{i+1}"].sample, address: ["結婚式","パーティー","デート","旅行"].sample,
  wifi: [true, false].sample, pool: [true, false].sample, parking: [true, false].sample, breakfast:[true, false].sample, gender:[true,false].sample, skin_color: rand(1..3), hair_color: rand(1..4))
  HotelPicture.create!(hotel_id: i+1, picture: "001.jpg")
end
HotelPicture.create!(hotel_id: 1, picture: "001.jpg")
HotelPicture.create!(hotel_id: 1, picture: "001.jpg")

HotelPicture.create!(hotel_id: 2, picture: "001.jpg")
HotelPicture.create!(hotel_id: 2, picture: "001.jpg")

99.times do |n|
  name  = Faker::Name.name
  email = "user#{n + 1}@hotel.com"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               picture: "avatar/#{rand(7)}.jpg"
              )
end
users = User.order(:created_at).take(6)
User.first.update_attributes(admin: true)
Admin.create!(email: "admin@gmail.com",
              password: "adminadmin")

HotelPicture.all.each do |ii|
  ii.update_column(:picture, "001.jpg")
end
