class RestsController < ApplicationController
  before_action :auth_line_id,except: [:new]
  before_action :debug_info

  def index
    @rests = @current_user.rests
  end

  def create
    Rest.create(rest_date: Date.today,content: params["data"],user_id: @current_user.id)
    @rests = @current_user.rests
    render 'rests/index'
  end

  def new
  end

  def rest_params
    params[:rest][:user_id] = @current_user.id
    params[:rest][:content] = params["data"]
    params.require(:rest).permit(:rest_date, :content, :user_id)
  end

  def auth_line_id
    @current_user = User.find_by line_id: params[:source_user_id]
    render "chatbot/subscribe" unless @current_user
  end

  def debug_info
    puts ""
    puts "=== kamigo debug info start ==="
    puts "platform_type: #{params[:platform_type]}"
    puts "source_type: #{params[:source_type]}"
    puts "source_group_id: #{params[:source_group_id]}"
    puts "source_user_id: #{params[:source_user_id]}"
    puts "=== kamigo debug info end ==="
    puts ""
  end
end
