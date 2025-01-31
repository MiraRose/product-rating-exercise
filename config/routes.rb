# frozen_string_literal: true

Rails.application.routes.draw do
  resources :product, only: [:show, :index] do
    resources :review, only: [:index, :create]
  end
end
