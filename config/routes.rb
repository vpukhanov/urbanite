Rails.application.routes.draw do
  root "index#index"
  post "define", to: "index#define", as: "define"
  get "terms/:term", to: "terms#show", as: "term"

  get "up" => "rails/health#show", as: :rails_health_check
end
