class Api::V1::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.create! sign_up_params
    render json: {message: I18n.t("devise.registrations.signed_up_but_unconfirmed")},
      status: 200
  end
end
