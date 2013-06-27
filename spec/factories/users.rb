# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  alphabet = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + %w{~ ! @ # $ % ^ & * ( ) _ + - =}
  min_size = 8
  variation = 8

  sequence :password do |n|
    pass_length = (rand * variation) + min_size
    Faker::ArrayUtils.random_pick(alphabet, pass_length)
  end

  factory :user do
    email Faker::Internet.email
    password { generate :password }
  end
end
