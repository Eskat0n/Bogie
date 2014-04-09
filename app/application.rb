class MediaManager < Sinatra::Base
  set :root => '../'
  set :views => '../views'

  get '/' do
    haml :index
  end

end