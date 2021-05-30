module Api
	module V1
		class UsersController < ApplicationController
		
			def index
				users = User.order('created_at DESC')
			end

			def show (id)
				if user = User.find(id)
					render json: {status: "SUCCESS", message: "Loaded successfully", data: user}, status: :ok
				else
					render json: {status: "ERROR", message: "Not found"}, status: :not_found
				end

			end
			def create (params)
				user = User.new(params)
				if user.save
		          render json: {status: 'SUCCESS', message:'Saved', data: user},status: :ok
		        else
		          render json: {status: 'ERROR', message:'Not saved', data: user.errors},status: :unprocessable_entity
		        end
			end

			def destroy (id)
		        user = User.find(id)
		        user.destroy
		        render json: {status: 'SUCCESS', message:'Deleted ', data: user},status: :ok
	      	end
		
			def update (params)
		        user = User.find(params.id)
		        if user.update_attributes(params)
		          render json: {status: 'SUCCESS', message:'Updated', data:user},status: :ok
		        else
		          render json: {status: 'ERROR', message:'Not updated', data: user.errors},status: :unprocessable_entity
		        end
	        end
		end
		
	end
end