require 'sinatra'
require 'sinatra/assetpack'

class App < Sinatra::Base
  register Sinatra::AssetPack

  assets {
    serve '/js',     {:from => 'assets/js'}
    serve '/css',    {:from => 'assets/css'}
    serve '/images', {:from => 'assets/images'}
    serve '/fonts',  {:from => 'assets/fonts'}

    css :app,   ['css/app.css']
    js :app, ['js/app.js']

    css_compression :sass
  }

  set :scss, { :load_paths => [ "#{App.root}/assets/css" ] }

  get '/' do
    erb :index
  end
end

