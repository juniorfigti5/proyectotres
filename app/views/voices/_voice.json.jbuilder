json.extract! voice, :id, :contest_id, :email, :name, :surname, :upload_date, :status_id, :original_file, :converted_file, :created_at, :updated_at
json.url voice_url(voice, format: :json)
