require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/formkeeper'
require 'mail'

require_relative './config/mail'

class App < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::FormKeeper

  assets {
    serve '/js',     {:from => 'assets/js'}
    serve '/css',    {:from => 'assets/css'}
    serve '/images', {:from => 'assets/images'}
    serve '/fonts',  {:from => 'assets/fonts'}

    css :app, ['css/app.css']
    js  :app, ['js/app.js']

    css_compression :sass
  }

  set :scss, { :load_paths => [ "#{App.root}/assets/css" ] }

  form_messages File.expand_path(File.join(File.dirname(__FILE__), 'config', 'form_messages.yaml'))

  get '/' do
    erb :index
  end

  post '/contact' do
    contact_form = form do
      filters :strip
      field   :name,    :present => true
      field   :email,   :present => true, :email => true
      field   :message, :present => true
    end

    if contact_form.failed?
      fill_in_form erb(:index)
    else
      Mail.deliver do
        from    contact_form[:email]
        to      ENV['CONTACT_EMAIL']
        subject "BitShift communication from #{contact_form[:name]}"
        body    contact_form[:message]
      end

      erb(:message_sent)
    end
  end
end

