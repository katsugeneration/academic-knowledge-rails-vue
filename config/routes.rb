# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :academic_search, only: [] do
    collection do
      get '/', :action => :index
    end
  end
end
