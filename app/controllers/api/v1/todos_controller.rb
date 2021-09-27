class Api::V1::TodosController < ApplicationController
    def index
        @todos = Todo.limit(params[:_limit])
        render json: @todos
    end
    
    def show
        @todo = Todo.find(params[:id])
        render json: @todo
    end
    
    def create
        @todo = Todo.new(todo_params)
        if @todo.save
            render json: @todo
        else
            render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def update
        @todo = Todo.find(params[:id])
        if @todo.update(todo_params)
            render json: @todo
        else
            render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy
        render json: { message: 'Todo deleted' }
    end
    
    private
    def todo_params
        params.permit(:title, :userId, :completed)
    end
end
