class Contest < ApplicationRecord
	belongs_to :user
	has_attached_file :banner, :style => { :small => "150x150>", :large => '300x400' },
                  :url  => "/assets/constests/:id/:style/:basename.:extension",
				  :path => ":rails_root/public/assets/constests/:id/:style/:basename.:extension", 
				  validate_media_type: false

	
	validates_attachment_size :banner, :less_than => 5.megabytes
	validates_attachment_content_type :banner, :content_type => ['image/jpeg', 'image/png']

	validates :name,  presence: true
	validates :url,  presence: true
	validates :value,  presence: true
	validates :script,  presence: true
	validates :recomendations,  presence: true
end
