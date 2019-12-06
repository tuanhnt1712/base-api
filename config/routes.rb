class ActionDispatch::Routing::Mapper
  def draw routes_name
    instance_eval File.read(Rails.root.join("config/routes/#{routes_name}.rb"))
  end
end

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, skip: :all
  draw :api
end
