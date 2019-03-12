Gem::Specification.new do |s|
  s.name = 'easter'
  s.version = '0.2.0'
  s.summary = 'Calculates Easter day as well as related days'
  s.description = 'Returns the date for Easter, Ash Wednesday, Palm Sunday, ' +
      'Good Friday, Ascension Day, and Pentecost.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/easter.rb']
  s.add_runtime_dependency('human_speakable', '~> 0.1', '>=0.1.2') 
  s.signing_key = '../privatekeys/easter.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/easter'
  s.required_ruby_version = '>= 2.1.2'
end
