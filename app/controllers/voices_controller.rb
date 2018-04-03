require 'net/http'

class VoicesController < ApplicationController
  before_action :set_voice, only: [:show, :edit, :update, :destroy]

  # GET /voices
  # GET /voices.json
  def index
    @voices = Voice.all
  end

  # GET /voices/1
  # GET /voices/1.json
  def show
  end

  # GET /voices/new
  def new
    @voice = Voice.new
    @voice.contest_id = Contest.find(params[:contest_id])
  end

  # GET /voices/1/edit
  def edit
  end

  # POST /voices
  # POST /voices.json
  def create
    @voice = Voice.new(voice_params)
    @voice.upload_date = Date.today.to_s
    @voice.status_id = 1
    logger.debug '-----------------------'+@voice.original_file.path
    respond_to do |format|
      if @voice.save
        logger.debug @voice.id
        Aws.use_bundled_cert!
        sqs = Aws::SQS::Client.new(region: 'us-east-2', credentials: Aws::Credentials.new())
        resp = sqs.send_message({queue_url: "https://sqs.us-east-2.amazonaws.com/800983206590/SQSVocesCloud",
                                  message_body: @voice.to_json,
                                  delay_seconds: 1
                                  })
        ConMailer.confirmation(@voice).deliver     
        format.html { redirect_to '/contests/'+@voice.contest.url, notice: 'Voice was successfully added.' }
        format.json { render :show, status: :created, location: @voice }
      else
        format.html { render :new }
        format.json { render json: @voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voices/1
  # PATCH/PUT /voices/1.json
  def update
    respond_to do |format|
      if @voice.update(voice_params)
        format.html { redirect_to @voice, notice: 'la voz se actualizó correctamente.' }
        format.json { render :show, status: :ok, location: @voice }
      else
        format.html { render :edit }
        format.json { render json: @voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voices/1
  # DELETE /voices/1.json
  def destroy
    @voice.destroy
    respond_to do |format|
      format.html { redirect_to voices_url, notice: 'La voz fue eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voice
      @voice = Voice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voice_params
      params.require(:voice).permit(:contest_id, :email, :name, :surname, :upload_date, :status_id, :original_file, :converted_file)
    end
end
