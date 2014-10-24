# run `ruby overlord.rb` to run a webserver for this app

require "haml"
require "pry"
require "sinatra/base"
require "sinatra"
require_relative "src/bomb"
require_relative "src/wire_box"
require_relative "src/bomb_timer"
require_relative "src/bomb_code_box"

enable :sessions

class Overlord < Sinatra::Application
  WIREBOX_COLORS = [:red, :green, :blue, :yellow, :orange]
  set :haml, format: :html5
  set :sessions, true

  get '/' do
    @bomb = session[:bomb] || new_bomb
    session[:bomb] = @bomb
    haml(:index)
  end

  get '/snip/:color' do
    @bomb = session[:bomb]
    wirebox.snip(params[:color].to_sym)
    timer.stop if timer.started? && wirebox.deactivated?
    redirect to('/')
  end

  post '/set/:seconds' do
    @bomb = session[:bomb]
    timer.reset(params[:seconds].to_i)
  end

  get '/enter/:code' do
    @bomb = session[:bomb]
    if codebox.active?
      codebox.deactivate(params[:code])
      timer.stop unless codebox.active?
    else
      codebox.activate(params[:code])
      timer.start unless wirebox.deactivated?
    end
    redirect to('/')
  end

  get '/reset' do
    session[:bomb] = new_bomb
    redirect to('/')
  end

  def deactivate(codebox, code)
    codebox.deactivate(code)
  end

  def activate(codebox, timer, code, time)
    codebox.activate(code)
    timer.reset(time)
    timer.start
  end

  def new_bomb
    wirebox = random_wirebox
    codebox = BombCodeBox.new
    timer = BombTimer.new
    Bomb.new(wirebox: wirebox, timer: timer, codebox: codebox)
  end

  def random_wirebox
    WireBox.new(wire_colors: WIREBOX_COLORS, safe_color: WIREBOX_COLORS.sample)
  end

  def wirebox
    @bomb.devices[:wirebox]
  end

  def codebox
    @bomb.devices[:codebox]
  end

  def timer
    @bomb.devices[:timer]
  end

  run! if app_file == $PROGRAM_NAME
end
