require 'rails_helper'

RSpec.describe ReviewController, :type => :controller do
    describe "GET index" do
        let!(:product) {FactoryBot.create(:product)}

        context "when getting successfully" do
            context "when it's a default call without sort or order params" do
                subject {get :index, params: {:product_id => product.id}}

                let!(:review) {FactoryBot.create(:review, :product_id => product.id)}
                let!(:review2) {FactoryBot.create(:review, :product_id => product.id)}

                it "returns a 200" do
                    subject
                    expect(response).to have_http_status(:ok)
                end

                it "returns sorted by date descending (most recent first)" do
                    subject
                    parsed_body = JSON.parse(response.body)
                    expect(parsed_body[0]["id"]).to eq(review2.id)
                end
            end

            context "when it's a rating sort call" do
                let!(:review) {FactoryBot.create(:review, :product_id => product.id, :rating => 1)}
                let!(:review2) {FactoryBot.create(:review, :product_id => product.id, :rating => 5)}

                context "when it's without a sort order" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "rating"}}

                    it "sorts by rating descending" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review2.id)
                    end
                end

                context "when it's without a sort order" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "rating"}}

                    it "sorts by rating descending" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review2.id)
                    end
                end

                context "when sort order is ascending" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "rating", :sort_order => "asc"}}

                    it "sorts by rating ascending" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review.id)
                    end
                end

                context "when sort order is descending" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "rating", :sort_order => "desc"}}

                    it "sorts by rating descending" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review2.id)
                    end
                end
                
            end

            context "when it's a date sort call" do
                let!(:review) {FactoryBot.create(:review, :product_id => product.id)}
                let!(:review2) {FactoryBot.create(:review, :product_id => product.id)}

                context "when it's without a sort order" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "date"}}

                    it "returns sorted by date descending (most recent first)" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review2.id)
                    end
                end

                context "when sort order is ascending" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "date", :sort_order => "asc"}}

                    it "sorts by date ascending" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review.id)
                    end
                end

                context "when sort order is descending" do
                    subject {get :index, params: {:product_id => product.id, :sort_by => "date", :sort_order => "desc"}}

                    it "sorts by date descending" do
                        subject
                        parsed_body = JSON.parse(response.body)
                        expect(parsed_body[0]["id"]).to eq(review2.id)
                    end
                end
            end
        end
    end

    describe "POST create" do
        let!(:product) {FactoryBot.create(:product)}
        let(:headline) { "Blah" }
        let(:author) { "John Smith" }
        let(:rating) { 1 }
        let(:body) {"This is a post"}
 
        context "when creating successfully" do
            subject {post :create, params: { :product_id => product.id, :headline => headline, :author => author, :rating => rating, :body => body}}
            it "returns a 200" do
                subject
                expect(response).to have_http_status(:ok)
            end

            it "creates a review" do
                expect{ subject }.to change{ Review.count }.by (1)
            end

            it "creates review with expected values" do
                subject

                review = Review.order("created_at").last
                expect(review[:headline]).to eq(headline)
                expect(review[:author]).to eq(author)
                expect(review[:rating]).to eq(rating)
                expect(review[:body]).to eq(body)
            end

            describe "when body is nil" do
                let(:body) {nil}

                it "creates review with body as empty string" do
                    subject

                    review = Review.order("created_at").last
                    expect(review[:body]).to eq("")
                end
            end
        end  
    end
end