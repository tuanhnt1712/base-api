class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :doorkeeper_authorize!

  def create
    user = User.create! sign_up_params
    render json: {message: "sign up successfuly"},
      status: 200
  end
end
