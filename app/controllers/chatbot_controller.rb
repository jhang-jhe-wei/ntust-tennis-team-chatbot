class ChatbotController < ApplicationController
  before_action :auth_line_id, except: [:notify, :sign_up, :user_setup]
  before_action :debug_info

  def subscribe
  end

  def notify
    @uri = URI.decode(lotify.get_auth_link("state"))
  end

  def profile
    @user = @current_user
  end

  def sign_up
    @user = User.new
    @token = lotify.get_token(params["code"])
    response = lotify.send(@token, message: "恭喜您成為台科大網球隊的訂閱者，之後將會有訊息傳達給您，請鼻要封鎖偶; (T＿T);")
  end

  def user_setup
    data = params["data"].split(":")
    @user = @current_user || User.new(line_id: params[:source_user_id])
    @user.student_id = data[0]
    @user.name = data[1]
    @user.token = data[2] if data[2].present?
    @user.save
    render 'chatbot/profile'
  end
  def auth_line_id
    @current_user = User.find_by line_id: params[:source_user_id]
    render "chatbot/subscribe" unless @current_user
  end

  def lotify
    lotify = Lotify::Client.new(
      client_id: ENV["LINE_NOTIFY_CHANNEL_ID"],
      client_secret: ENV["LINE_NOTIFY_CHANNEL_SECRET"],
      redirect_uri: sign_up_url,
    )
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
