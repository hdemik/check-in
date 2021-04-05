require 'sinatra'
require 'sinatra/config_file'

class CheckIn < Sinatra::Base
  register Sinatra::ConfigFile
  config_file 'config.yml'

  def avail_languages
    { en: '🇬🇧',
      de: '🇩🇪',
      # fr: '🇫🇷',
      nl: '🇳🇱',
      # jp: '🇯🇵'
    }
  end

  def language
    language = params[:lang].nil? ? :en : params[:lang].to_sym
    avail_languages.keys.include?(language) ? language : :en
  end

  def questions
    settings.send(language)
  end

  def other_languages
    avail_languages.reject { |k,v| k == language }
  end

  def rand_question
    questions.shuffle.first
  end

  def render
    content_type :json
    { question: @question }.to_json
  end

  get '/' do
    redirect '/index.html'
  end

  get '/questions' do
    content_type :json
    { questions: questions() }.to_json
  end

  get '/!/:id' do |id|
    @question = (questions[id.to_i - 1] || rand_question)
    render
  end

  get '/today' do
    day = Time.new.day
    day = day - questions.count if day > questions.count;

    @question = questions[day-1] || rand_question
    render
  end
end