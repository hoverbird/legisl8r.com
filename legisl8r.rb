require 'rubygems'
require 'sinatra'
require 'haml'
require 'ny-times-congress'

include NYTimes::Congress
Base.api_key = ENV['NY_TIMES_CONGRESS_API_KEY']

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
      # congress/senate/110/members/S000770/compare/D000563
get '/congress/:chamber/:session/members/:legislator_1/compare/:legislator_2' do
  @congress = Congress.new(params[:session], params[:chamber])
  @legislator_1, @legislator_2 = Legislator.find(params[:legislator_1]), Legislator.find(params[:legislator_2])
  @comparison = @congress.compare(@legislator_1, @legislator_2)
  erb :compare
end
