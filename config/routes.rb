# frozen_string_literal: true

Rails.application.routes.draw do
  resources :members
  resources :matches
end
