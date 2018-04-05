class ConvertirVocesNegocio

    def convertir_voces(id_voz)
        @voice = Voice.find(id_voz)
        puts 'Tengo el video'
        puts @voice.to_json
        if @voice.original_file_file_name != nil then
            puts 'Voz: '+ @voice.original_file_file_name
            #Crear url destino en formato mp3
            raizS3 = "https://s3.us-east-2.amazonaws.com/vocesclouds3/"
            raizInterna = "public/assets/voices/"
            raiz = "#{raizS3}#{raizInterna}"
            nombre_voz = File.basename(@voice.original_file_file_name,File.extname(@voice.original_file_file_name))
            contest_id = @voice.contest_id 
            nombre_voz_origen = "#{nombre_voz}.wav"
            nombre_voz_destino = "#{contest_id}_#{id_voz}_#{nombre_voz}"
            url_origen = "#{raiz}#{id_voz}/original/#{nombre_voz}.wav"
            url_destino = "#{raiz}#{id_voz}/convertido/#{nombre_voz_destino}.mp3"
            #if !Dir.exist?("#{raiz}#{id_voz}/convertido/") then
                #mkdir = 'mkdir "' + "#{raiz}#{id_voz}/convertido/" + '"'
                #puts mkdir
                #system(mkdir)
            #end
            puts "#{url_origen}"
            puts "#{url_destino}"
  
            #Convertir videos
            #self.convertir_ext_a_mp3(url_origen, url_destino)
            ruta_temp = Rails.root.to_s+'/public/assets/voices/temp/'
            if !Dir.exist?(ruta_temp) then
                mkdir = 'mkdir "' + "#{ruta_temp}" + '"'
                puts mkdir
                system(mkdir)
            end
            self.convertir_ext_a_mp3_s3(ruta_temp, "#{raizInterna}#{id_voz}/original/#{nombre_voz_origen}", 
            "#{raizInterna}#{id_voz}/convertido/#{nombre_voz_destino}.mp3", nombre_voz_origen,
            "#{nombre_voz_destino}.mp3")

            @voice.status_id = 2
            @voice.converted_file_file_name = "#{nombre_voz_destino}.mp3"
            @voice.converted_file_content_type = "audio/mp3"
            @voice.converted_file_file_size = 58
            @voice.converted_file_updated_at = Time.now
            @voice.surname = 'procesado'
            @voice.save({force: true})
            puts 'Guardado'
            ConMailer.confirmation(@voice).deliver
            puts 'Correo enviado'
        end
    end

    def convertir_ext_a_mp3(ruta_archivo_original, ruta_archivo_destino)
        puts "comenzando ffmpeg -i #{ruta_archivo_original} #{ruta_archivo_destino}"
        system("ffmpeg -i #{ruta_archivo_original} #{ruta_archivo_destino}")
        puts 'convertido'
    end

    def convertir_ext_a_mp3_s3(ruta_temp, ruta_archivo_original, ruta_archivo_destino, nombre_origen, nombre_destino)
        puts 'Comenzando'
        Aws.use_bundled_cert!
        client = Aws::S3::Client.new(region: 'us-east-2', credentials: Aws::Credentials.new())
        s3 = Aws::S3::Resource.new(client: client)
        bucket = s3.bucket('vocesclouds3')
        file_obj = bucket.object(ruta_archivo_original)
        file_obj.get(response_target: ruta_temp + nombre_origen)
        comando = 'ffmpeg -i ' + ruta_temp + nombre_origen +
            ' ' + ruta_temp + nombre_destino
        puts comando            
        IO.popen(comando) { |f| puts f }
        bucket.object(ruta_archivo_destino).upload_file(ruta_temp + nombre_destino, {acl: 'public-read'})
        File.delete(ruta_temp + nombre_origen)
        File.delete(ruta_temp + nombre_destino)
        puts 'convertido'
      end
  end