require 'sinatra'
require 'sinatra/config_file'

config_file 'config.yml'

def avail_languages
  @avail_languages ||= %w(de en nl fr jp)
end

def questions
  lang = params[:lang]
  if avail_languages.include?(lang)
    settings.send(lang)
  else
    settings.en
  end
end

def rand_question
  questions.shuffle.first
end

def typed_render
  if request.preferred_type.to_s == "text/html"
    erb :view
  else
    { question: @question }.to_json
  end
end

get '/' do
  @question = rand_question
  typed_render
end

get '/!/:id' do |id|
  @question = (questions[id.to_i - 1] || rand_question)
  typed_render
end

get '/today' do
  day = Time.new.day
  day = day - questions.count if day > questions.count;

  @question = questions[day-1]
  typed_render
end

__END__

@@ view
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/styles.css">
  <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
</head>
<body>
  <div class="backdrop"><div class="question"><%= @question %></div></div>
</body>
</html>