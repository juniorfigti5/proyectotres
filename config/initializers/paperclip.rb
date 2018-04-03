Paperclip.options[:content_type_mappings] = {
  :mp3 => "application/octet-stream",
  :ogg => "application/ogg",
  :m4a => "video/mp4"
}

Paperclip::Attachment.default_options[:url] = 'http://vocesclouds3.s3.amazonaws.com'
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-east-2.amazonaws.com'