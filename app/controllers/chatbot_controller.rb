class ChatbotController < ApplicationController
  before_action :auth_line_id, except: [:notify, :sign_up, :user_setup]
  before_action :debug_info


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
