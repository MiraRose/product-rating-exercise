class ReviewController < ApplicationController
    def index
        optional_params = params.permit(:sort_by, :sort_order)
        product_id = params.require(:product_id)

        product_reviews = []
        if optional_params[:sort_by] == "rating" && (optional_params[:sort_order].nil? || optional_params[:sort_order] == "desc") then
            product_reviews = Review.where(:product_id => product_id).order(rating: :desc)
        elsif optional_params[:sort_by] == "rating" && optional_params[:sort_order] == "asc"
            product_reviews = Review.where(:product_id => product_id).order(rating: :asc)
        elsif optional_params[:sort_by] == "date" && optional_params[:sort_order] == "asc"
            product_reviews = Review.where(:product_id => product_id).order(created_at: :asc)
        else
            product_reviews = Review.where(:product_id => product_id).order(created_at: :desc)
        end

        render json: product_reviews, status: :ok
    end
    
    def create
        optional_params = params.permit(:body)

        Review.create(
            :product_id => params.require(:product_id), 
            :headline => params.require(:headline), 
            :author => params.require(:author), 
            :rating =>  params.require(:rating), 
            :body => optional_params[:body]
            )

        render json: {}, status: :ok
    end
end