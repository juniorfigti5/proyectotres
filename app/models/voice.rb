class Voice < ApplicationRecord
	belongs_to :contest
	belongs_to :status, optional: true
#	after_create :send_mail 
	has_attached_file :original_file,
                  :url  => "http://vocesclouds3.s3.amazonaws.com/",
                  :path => "/public/assets/voices/:id/:style/:basename.:extension", 
				  validate_media_type: false

    validates_attachment_presence :original_file
	validates_attachment_size :original_file, :less_than => 100.megabytes
	validates_attachment_content_type :original_file, :content_type => ['audio/wav',
		'audio/mpeg', 'video/mp4', 'audio/x-wav', 'application/ogg', 'audio/ogg', 
		'video/ogg',
		'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 
		'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio', 'application/octet-stream',
		'application/mp3', 'application/x-mp3'],
		message: 'El archivo debe ser de formato .mp3, .wav or ogg'

	validates :email,  presence: true
	validates :name,  presence: true
	validates :surname,  presence: true



#	def send_mail

#		
#		MyMailer.send_email(@voice).deliver		
#	end

#	def send_mail
#		#VoiceMailer.convert_confirmation.deliver_later
#	end

end
