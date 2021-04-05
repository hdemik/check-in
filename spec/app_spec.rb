require "./app/check-in.rb"

require 'logger'
$log = Logger.new STDERR

describe CheckIn do
  let(:app) { CheckIn.new }

  it "works" do
    get "/"
    expect(last_response.status).to eq(200)
  end

  it "returns json when requested" do
    header 'Accept', 'application/json'
    get "/"
    expect(last_response.content_type).to eq("application/json")
  end

  it "returns a list of questions" do
    get "/questions"
    expect(last_response.content_type).to eq("application/json")
  end
end
