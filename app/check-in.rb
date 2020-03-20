require 'sinatra'

def questions
  [ 'What should you do today to make someone else happy?',
    'What am I grateful for?',
    'What do I want to learn today?',
    'Whom would I most like to look over the shoulder?',
    'What books are you reading?',
    'What books should I be reading?',
    'Try anything new lately?',
    'Anything inspire you lately?',
    'Seen any great design recently?',
    'What did you do this weekend?',
    'What am I going to do differently today?',
    'What - realistic - dream is on your wishlist?',
    'What do you want to do for the first time in your life?',
    'Which exciting things, that are challenging for you,<br/>will you be doing in the next days?',
    'Which decisions can you make today to make tomorrow a better day?',
    'Name 3 moments/experiences from the past few days for which you are grateful',
    'Failing to plan is planning to fail;<br/>So what could make tomorrow a great day?'
  ];
end

def rand_question
  questions.shuffle.first
end

def typed_render
  if request.preferred_type.to_s == "text/html"
    erb :index
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
  day = day - 17 if day > 17;

  @question = questions[day-1]
  typed_render
end