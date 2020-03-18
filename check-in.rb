require 'sinatra'

get '/' do
  questions = [
    'What should you do today to make someone else happy?',
    'What could you decide today to make tomorrow a better day?'
  ];

  return questions.shuffle.first
end