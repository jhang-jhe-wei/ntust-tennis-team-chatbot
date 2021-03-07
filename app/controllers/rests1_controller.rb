class RestsController < ApplicationController
  before_action :auth_line_id
  before_action :debug_info
  before_action :set_rest, only: [:show, :edit, :update, :destroy]
  def create_rest
    Rest.create(rest_date: Date.today,content: params["data"],user_id: @current_user.id)
    @rests = @current_user.rests
    render 'rests/index'
  end
  # GET /rests
  # GET /rests.json
  def index
    @rests = @current_user.rests
  end

  # GET /rests/1
  # GET /rests/1.json
  def show
  end

  # GET /rests/new
  def new
    @rest = Rest.new(user_id: @current_user.id)
  end

  # GET /rests/1/edit
  def edit
  end

  # POST /rests
  # POST /rests.json
  def create
    @rest = Rest.new(rest_params)

    respond_to do |format|
      if @rest.save
        @rests = Rest.all
        format.html { redirect_to @rest, notice: "Rest was successfully created." }
        format.json { render :show, status: :created, location: @rest }
        format.line { render :index }
      else
        format.html { render :new }
        format.json { render json: @rest.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@rest.errors.to_s) }
      end
    end
  end

  # PATCH/PUT /rests/1
  # PATCH/PUT /rests/1.json
  def update
    respond_to do |format|
      if @rest.update(rest_params)
        @rests = Rest.all
        format.html { redirect_to @rest, notice: "Rest was successfully updated." }
        format.json { render :show, status: :ok, location: @rest }
        format.line { render :index }
      else
        format.html { render :edit }
        format.json { render json: @rest.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@rest.errors.to_s) }
      end
    end
  end

  # DELETE /rests/1
  # DELETE /rests/1.json
  def destroy
    @rest.destroy
    @rests = Rest.all
    respond_to do |format|
      format.html { redirect_to rests_url, notice: "Rest was successfully destroyed." }
      format.json { head :no_content }
      format.line { render :index }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rest
    @rest = Rest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rest_params
    params[:rest][:user_id] = @current_user.id
    params[:rest][:content] = params["data"]
    params.require(:rest).permit(:rest_date, :content, :user_id)
  end

  def auth_line_id
    @current_user = User.find_by line_id: params[:source_user_id]
    redirect_to subscribe_path unless @current_user
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
