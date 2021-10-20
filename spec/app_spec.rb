require "./app/check-in.rb"

require 'logger'
$log = Logger.new STDERR

describe CheckIn do
  let(:app) { CheckIn.new }

  it "works" do
    get "/"
    expect(last_response.status).to eq(200)
  end

  it "serves an index.html file" do
    get "/"
    expect(last_response.body).to match(/<!doctype html>/i);
  end

  it "serves the index.html as text/html" do
    get "/"
    expect(last_response.content_type).to match(/text\/html/);
  end

  it "serves a daily question" do
    get "/today"
    expect(last_response.body).to have_jason([:question, :id])
  end

  it "serves a random question" do
    get "/!"
    expect(last_response.body).to have_jason([:question, :id])
  end

  it "serves a numbered question" do
    get "/!/1"
    expect(last_response.body).to have_jason([:question, :id])
  end

  it "throws an error when asking for a question that does not exist"

  it "throws an error when asking for a negative question id"

  it "serves a list of all questions" do
    get "/questions"
    expect(last_response.body).to have_jason( questions: Jason.spec( type: Array ))
  end

  it "serves questions in het Nederlands" do
    get "/questions?lang=nl"
    expect(last_response.body).to have_jason( questions: Jason.spec( type: Array ), language: Jason.spec( type: String ))
    expect(JSON.parse(last_response.body)["language"]).to eq("nl")
  end

  it "serves questions in Deutsch" do
    get "/questions?lang=de"
    expect(last_response.body).to have_jason( questions: Jason.spec( type: Array ), language: Jason.spec( type: String ))
    expect(JSON.parse(last_response.body)["language"]).to eq("de")
  end

  it "serves questions in English" do
    get "/questions?lang=en"
    expect(last_response.body).to have_jason( questions: Jason.spec( type: Array ), language: Jason.spec( type: String ))
    expect(JSON.parse(last_response.body)["language"]).to eq("en")
  end

  it "serves no questions in japanese" do
    get "/questions?lang=jp"
    expect(JSON.parse(last_response.body)["language"]).to_not eq("jp")
  end

  it "serves questions in english by default" do
    get "/questions"
    expect(JSON.parse(last_response.body)["language"]).to eq("en")
  end

  it "serves questions in english per fallback" do
    get "/questions?lang=jp"
    expect(JSON.parse(last_response.body)["language"]).to eq("en")
  end
end
