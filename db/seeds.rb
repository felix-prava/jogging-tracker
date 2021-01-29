User.create!(name: "Felix ",
            email: "felix@yahoo.com",
            password: "password",
            password_confirmation: "password")

99.times do |n|
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
    users.each { |user| user.jogtimes.create!(minutes: minutes, distance: 2.5, weekday: 2021-01-29) }
end
