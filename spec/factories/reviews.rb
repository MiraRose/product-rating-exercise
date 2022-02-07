# == Schema Information
#
# Table name: reviews
#
#  id         :uuid             not null, primary key
#  author     :string           not null
#  body       :string
#  headline   :string           not null
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :uuid
#
# Indexes
#
#  index_reviews_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#

FactoryBot.define do
    factory :review do
        author {Faker::Name.name}
        headline {Faker::Alphanumeric.alpha(number: 20)}
        rating {Faker::Number.between(from: 1, to: 5)}
        body {nil}
        end
    end
