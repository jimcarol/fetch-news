Gem::Specification.new do |s|
  s.name        = 'fetch_news'
  s.version     = '0.0.3'
  s.date        = '2019-06-11'
  s.summary     = "fetch page content from page!"
  s.description = "A simple spider gem"
  s.authors     = ["Jim He"]
  s.email       = '6756971174@qq.com'
  s.files       = Dir['lib/**/*']
  s.license     = 'MIT'
  s.homepage    = "https://github.com/jimcarol/fetch-news"

  s.add_runtime_dependency 'mechanize'
  s.add_runtime_dependency 'watir'
end