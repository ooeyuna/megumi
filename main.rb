require 'pry' unless ['production'].include?(ENV['RACK_ENV'])
require 'require_all'
require 'yaml'
require 'logger'
require 'json'
require_all 'megumi'

dl = Megumi::DataLoader.new
dl.load_all
p dl.data

require 'sinatra'

set :data_loader, dl

get '/*' do |path|
  content_type :json
  data = settings.data_loader.data
  data.dig(*path.split('/')).to_json
end

post '/refresh' do
  content_type :json
  dl = settings.data_loader
  dl.refresh
  dl.data.to_json
end
