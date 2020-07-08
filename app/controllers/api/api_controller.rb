# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

    protected

    def find_user
      @user = User.find(params[:user_id])
    end

    def record_not_found(exception)
      render json: { error: exception.message }, status: 404
      nil
    end
  end
end
