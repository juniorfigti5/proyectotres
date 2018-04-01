namespace :convert do

  task :con => :environment do
      x  = Voice.all.count
      x.times do|n|
        	n=n+1
        if Voice.exists?(n)
         voice = Voice.find(id=n)
 
         if voice.surname != "procesado"
         	 puts " ANALIZANDO VOZ #{n}"
        	 puts "             --> VOZ SIN PROCESAR               "
          
              x = Dir.glob("public/assets/voices/#{n}/original/*.ogg")
              y = x.at(0)
              if y.nil? == true
              	puts "--NO HAY AUDIO EN .OGG--"
              #para eliminar los audios
              #system "rm '#{y}'"    
              else
              system("ffmpeg -i #{y} #{y}.mp3")
              end

                 
              a = Dir.glob("public/assets/voices/#{n}/original/*.wav")
              b = a.at(0)
              #para eliminar los audios
              #system "rm '#{b}'"    
              if b.nil? == true
              	 puts "--NO HAY AUDIO EN .WAV --"
              else
              system("ffmpeg -i #{b} #{b}.mp3")
              end
           voice = Voice.find(id=n)
           voice.surname = 'procesado'
           voice.save!
           ConMailer.confirmation(voice).deliver

        	 else
             puts"             --> VOZ #{n} PROCESADA                   "
           end
          end
        end
    end 


    task :t => :environment do
    
    voice = Voice.find(20)

   # puts voice.surname
   # puts 

    puts "........"

    #voice.surname = 'prueba'
    #voice.name = 'prueba cron'
    #voice.save!

    #puts voice.surname
   puts voice.original_file_name
     
    end 
end
