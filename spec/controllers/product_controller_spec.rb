require 'rails_helper'

RSpec.describe ProductController, :type => :controller do
    describe "GET index" do
        subject {get :index }

        let!(:product2) {FactoryBot.create(:product)}
        let!(:product) {FactoryBot.create(:product)}
        let!(:product3) {FactoryBot.create(:product)}

        context "when reviews exist" do
            let!(:review3) {FactoryBot.create(:review, :product_id => product2.id, :rating => 3)}
            let!(:review4) {FactoryBot.create(:review, :product_id => product2.id, :rating => 5)}

            let!(:review) {FactoryBot.create(:review, :product_id => product.id, :rating => 5)}
            let!(:review2) {FactoryBot.create(:review, :product_id => product.id, :rating => 5)}

            let!(:review5) {FactoryBot.create(:review, :product_id => product3.id, :rating => 1)}

            context "when getting successfully" do
                it "returns a 200" do
                    subject
                    expect(response).to have_http_status(:ok)
                end
    
                it "returns products sorted with best rated products first" do
                    subject
                    parsed_body = JSON.parse(response.body)
                    expect(parsed_body[0]["id"]).to eq(product.id)
                end
            end
        end

        context "when reviews don't exist" do
            context "when getting successfully" do
                it "returns a 200" do
                    subject
                    expect(response).to have_http_status(:ok)
                end
    
                it "returns products" do
                    subject
                    parsed_body = JSON.parse(response.body)
                    expect(parsed_body.length).to eq(3)
                end
            end
        end
    end
end