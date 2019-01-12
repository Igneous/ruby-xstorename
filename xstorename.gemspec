Gem::Specification.new do |s|
  s.name        = 'xstorename'
  s.version     = '0.1.0'
  s.date        = '2018-01-11'
  s.summary     = "xstorename"
  s.description = "A ruby wrapper around Xlib's XStoreName"
  s.authors     = ["Bucky Wolfe"]
  s.email       = 'pmigneous@gmail.com'
  s.files       = Dir["ext/**/*"]
  s.homepage    = 'http://github.com/igneous/ruby-xstorename'
  s.license     = 'MIT'

  s.extensions  = Dir.glob("ext/xstorename/extconf.rb")
end
