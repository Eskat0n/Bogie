class Bogie < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, File.join(settings.root, 'views')

  def initialize
    @client = IronMQ::Client.new
    @queue = @client.queue('download_tasks')

    super
  end

  get '/' do
    haml :index
  end

  post '/download' do
    task = {
        url: params[:url],
        provider: params[:provider],
        type: params[:type]
    }
    @queue.post(JSON.generate(task))

    redirect '/'
  end

end