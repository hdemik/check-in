require 'sinatra'
require 'sinatra/config_file'

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

def typed_render
  @languages = other_languages

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

  @question = questions[day-1] || rand_question
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
  <div class="backdrop">
    <div class="languages">
      <% @languages.each do |lang,flag| %>
        <a href="?lang=<%= lang %>"><%= flag %></a>
      <% end %>
    </div>
    <div class="question"><%= @question %></div>
  </div>
</body>
</html>