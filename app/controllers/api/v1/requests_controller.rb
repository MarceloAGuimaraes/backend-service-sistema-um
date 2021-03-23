module Api
  module V1
    class RequestsController < ApplicationController
      before_action :validate_user, only: [:create]

      def create
        @request = Request.create(user_id: @user.id)
        handle_address
        handle_questions
        SistemaDoisServiceWorker.perform_async(@request.id, @request.address.to_param)
        render json: { request: @request }, status: 200
      end

      def update_address
        @request = Request.find(params[:id])
        @request.address.update(lat: params[:lat], long: params[:long])
        render json: { message: 'Endereço atualizado'}, status: 200
      end

      private

      def handle_address
        if @request.address.present?
          @request.address.update(address_params)
        else
          @request.create_address(address_params)
        end
      end

      def handle_questions
        request_params.each do |_k, text|
          Question.create!(
            text: text,
            request_id: @request.id
          )
        end
      end

      def address_params
        params.require(:address_attributes).permit(
          :city, :neighborhood, :street, :uf, :zip_code
        )
      end

      def request_params
        params.require(:request_info)
      end

      def validate_user
        @user = User
                .create_with(name: user_params[:name], phone: user_params[:phone])
                .find_or_create_by(email: user_params[:email])
      end

      def user_params
        params.require(:user_info).permit(
          :name, :email, :phone
        )
      end
    end
  end
end