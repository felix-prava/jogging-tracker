User.create!(name: "Felix",
            email: "mihai_prava@yahoo.com",
            password: "abcdef",
            password_confirmation: "abcdef",
            admin: true)

User.create!(name: "Mihai",
            email: "mihai.prava@gmail.com",
            password: "abcdef",
            password_confirmation: "abcdef",
            manager: true)

45.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@yahoo.com"
    password = "password"
    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end

# Generate jogtimes for a subset of users.
users = User.order(:created_at).take(6)
50.times do |n|
    minutes = n + 1
    users.each { |user| user.jogtimes.create!(minutes: minutes, distance: 2.5, weekday: Date.today - n) }
end
