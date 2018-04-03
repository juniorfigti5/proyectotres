class ConvertirVocesNegocio

    def convertir_voces(id_voz)
        @voice = Voice.find(id_voz)
        puts 'tengo el video'
        puts @voice.to_json
        if @voice.original_file_file_name != nil then
            puts 'Voz: '+ @voice.original_file_file_name
            #Crear url destino en formato mp3
            raiz = Rails.root.to_s+'/public/assets/voices/'
            nombre_voz = @voice.original_file_file_name
            contest_id = @voice.contest_id 
            nombre_voz_destino = "#{contest_id}_#{id_voz}_#{nombre_voz}"
            url_origen = "#{raiz}#{id_voz}/original/#{nombre_voz}"
            url_destino = "#{raiz}#{id_voz}/convertido/#{nombre_voz_destino}.mp3"
            if !Dir.exist?("#{raiz}#{id_voz}/convertido/") then
                mkdir = 'mkdir "' + "#{raiz}#{id_voz}/convertido/" + '"'
                puts mkdir
                system(mkdir)
            end
            puts "#{url_origen}"
            puts "#{url_destino}"
  
            #Convertir videos
            self.convertir_ext_a_mp3(url_origen, url_destino)
        end
    end

    def convertir_ext_a_mp3(ruta_archivo_original, ruta_archivo_destino)
        puts "comenzando ffmpeg -i #{ruta_archivo_original} #{ruta_archivo_destino}"
        system("ffmpeg -i #{ruta_archivo_original} #{ruta_archivo_destino}")
        puts 'convertido'
    end
  end