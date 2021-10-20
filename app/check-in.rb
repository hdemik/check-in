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

  def not_found(resource)
    status 404
    { error: "resource #{resource} not found" }.to_json
  end

  before do
    content_type :json
  end

  get '/' do
    content_type :html
    send_file 'app/public/index.html'
  end

  get '/languages' do
    { languages: avail_languages, language: language }.to_json
  end

  get '/questions' do
    { questions: questions(), language: language }.to_json
  end

  get '/!' do
    question = rand_question
          id = questions.index(question)+1

    { question: question, id: id, language: language }.to_json
  end

  get '/!/:id' do |id|
    idx = id.to_i - 1
    return not_found(id) if idx < 0

    question = questions[idx]
    return not_found(id) if question.nil?

    { question: question, id: id, language: language }.to_json
  end

  get '/today' do
    day = Time.new.day
    day = day - questions.count if day > questions.count;

    question = questions[day-1] || rand_question
    { question: question, id: day, language: language }.to_json
  end
end