require 'rubygems'
require 'sinatra'
require 'haml'
require 'ny-times-congress'

include NYTimes::Congress
NYTimes::Congress::Base.api_key = ENV['NY_TIMES_CONGRESS_API_KEY']

get '/' do
  @joe = Legislator.find('B000444')
  @joe.bio
end


get '/legislator/:id' do
  @legislator = Legislator.find(params[:id])
  haml :show
end


get '/congress/:chamber/:session/members' do
  @congress = Congress.new(params[:session], params[:chamber])
  @members = @congress.members.values
  erb :index
end

get '/congress/:chamber/:session/members' do
  @congress = Congress.new(params[:session], params[:chamber])
  @members = @congress.members.values
  erb :index
end