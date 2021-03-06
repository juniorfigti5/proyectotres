Thread.new do
  puts 'Inicia llamado queue para procesamiento de voces'
  Aws.use_bundled_cert!
  #sqs = Aws::SQS::Client.new(region: 'us-east-2', credentials: Aws::Credentials.new('', ''))
  #receive_message_result = sqs.receive_message({
                          #queue_url: 'https://sqs.us-east-2.amazonaws.com/800983206590/SQSVocesCloud', 
                          #message_attribute_names: ["All"], # Receive all custom attributes.
                          #max_number_of_messages: 1, # Receive at most one message.
                          #wait_time_seconds: 5 # Do not wait to check for the message.
                          #})
  #receive_message_result.messages.each do |message|
      #resp = JSON.parse(message.body)
      #puts 'Se totea?'
      #cc = ConvertirVocesNegocio.new
      #puts 'convertir'
      #cc.convertir_voces(resp['id'])
      #puts "eliminar mensaje"
      #sqs.delete_message({
        #queue_url: 'https://sqs.us-east-2.amazonaws.com/800983206590/SQSVocesCloud',
        #receipt_handle: message.receipt_handle
      #})
      #puts 'Terminando Tarea ConvertidorVocesJob...'
  #end
  #puts 'termine'
  
  Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new()})
  poller = Aws::SQS::QueuePoller.new('https://sqs.us-east-2.amazonaws.com/800983206590/SQSVocesCloud')
  puts 'Ahora si Inicia Llamado queue para procesamiento de voces'
  poller.poll do |msg|
    resultado = JSON.parse(msg.body)
    puts 'Ejecutando Tarea ConvertidorVocesJob...'
    cc = ConvertirVocesNegocio.new
    cc.convertir_voces(resultado['id'])
    puts 'Terminando Tarea ConvertidorVocesJob...'
  end
  puts 'termine'
end