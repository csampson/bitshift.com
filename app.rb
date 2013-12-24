require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/formkeeper'

class App < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::FormKeeper

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

  form_messages File.expand_path(File.join(File.dirname(__FILE__), 'config', 'form_messages.yaml'))

  get '/' do
    erb :index
  end

  post '/contact' do
    form do
      filters :strip
      field   :name, :present => true
      field   :email, :present => true, :email => true
      field   :message, :present => true
    end

    if form.failed?
      fill_in_form erb(:index)
    else
      # TODO: send email
      # TODO: contact success page
    end
  end
end

