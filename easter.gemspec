Gem::Specification.new do |s|
  s.name = 'easter'
  s.version = '0.1.1'
  s.summary = 'Calculates Easter day as well as related days'
  s.description = 'Returns the date for Easter, Ash Wednesday, Palm Sunday, Good Friday, Ascension Day, and Pentecost.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.signing_key = '../privatekeys/easter.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/easter'
end
