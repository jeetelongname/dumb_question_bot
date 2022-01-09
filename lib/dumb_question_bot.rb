# frozen_string_literal: true

require 'json'
require 'dumb_question_bot/version'
require 'sinatra'

defaults = { title: 'some title', name: 'some instance name', description: 'some cool description' }

data = JSON.parse(File.read('./conf.json')).map do |key, elem|
  [key.to_sym, elem]
end.to_h

defaults.each do |key, elem|
  data[key] = elem if data[key].nil?
end

set :views, "#{settings.root}/../views"

get '/' do
  erb :index, locals: {
    title: data[:title],
    name: data[:name],
    description: data[:description]
  }
end

post '/after' do
  question = params[:question]
  erb :after, locals: { question: question }
end
