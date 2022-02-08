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
require 'rails_helper'

RSpec.describe Review, :type => :model do

    let!(:product) {FactoryBot.create(:product)}

    it "is valid with valid attributes" do
        review = FactoryBot.build(:review, :product_id => product.id)
        expect(review).to be_valid
    end

    it "isn't valid without a headline" do
        review = FactoryBot.build(:review, :product_id => product.id, :headline => nil)
        expect(review).to_not be_valid
    end

    it "isn't valid without an author" do
        review = FactoryBot.build(:review, :product_id => product.id, :author => nil)
        expect(review).to_not be_valid
    end

    it "isn't valid without a rating" do
        review = FactoryBot.build(:review, :product_id => product.id, :rating => nil)
        expect(review).to_not be_valid
    end

    it "isn't valid with rating more than 5" do
        review = FactoryBot.build(:review, :product_id => product.id, :rating => 6)
        expect(review).to_not be_valid
    end

    it "isn't valid with rating less than 1" do
        review = FactoryBot.build(:review, :product_id => product.id, :rating => 0)
        expect(review).to_not be_valid
    end
end
