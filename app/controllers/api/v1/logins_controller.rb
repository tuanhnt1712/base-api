class Api::V1::LoginsController < DeviseController
  skip_before_action :doorkeeper_authorize!

  def create
    user = User.find_for_database_authentication email: user_params[:email]
    raise Errors::Runtime::ActionFailed, :invalid unless user&.valid_password?(user_params[:password])

    # raise Errors::Runtime::ActionFailed, :not_confirmation unless user&.confirmed?
    # raise Errors::Runtime::ActionFailed, :deactive if user&.deactive?

    token = user.generate_token
    token_response = Doorkeeper::OAuth::TokenResponse.new(token).body
    created_at = token_response["created_at"]
    token_response["created_at"] = Time.zone.at(created_at).iso8601
    token_response["expires_on"] = Time.zone.at(created_at + token_response["expires_in"]).iso8601
    render json: {
      success: true,
      data: {
        token_info: token_response
      }
    }, status: 200
  end

  private

  def user_params
    params.require(:user).permit :email, :password
  end
end