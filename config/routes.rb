# frozen_string_literal: true

Rails.application.routes.draw do
  root 'members#index'

  resources :members
  resources :matches
end
