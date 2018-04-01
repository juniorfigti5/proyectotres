class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

  # GET /contests
  # GET /contests.json
  def index
    if current_user
      @contests = Contest.where(user_id: current_user).order(created_at: :desc)
    else
      @contests = Contest.all
    end
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    system "rake test CONTEST_ID=#{params[:id]}"
    @voices = Voice.where(contest_id: Contest.find_by(url: params[:url]))
    .paginate(:page => params[:page], :per_page => 50)
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit
  end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(contest_params)
    @contest.user_id = current_user.id
    respond_to do |format|
      if @contest.save
        format.html { redirect_to '/contests/'+@contest.url, notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    @contest = Contest.find_by(url: params[:contest][:url])
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to '/contests/'+@contest.url, notice: 'Contest was successfully updated.' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy

    @contest.user_id = current_user.id

    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find_by(url: params[:url])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:name, :banner, :url, :startDate, :endDate, :value, :script, :recomendations)
    end
end
