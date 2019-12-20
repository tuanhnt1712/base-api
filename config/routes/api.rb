namespace :api do
  namespace :v1 do
    devise_scope :user do
      post "signup", to: "registrations#create"
      post "signin", to: "logins#create"
    end
  end
end
