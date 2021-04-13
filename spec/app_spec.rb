require_relative '../app'
require 'rspec'
require 'rack/test'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end
  
  describe "GET #index" do
    before(:example) { get "/" }

    it "renders the index page" do
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Olá Application")
    end

    xit "render the form to upload file" do
      expect(last_response.body).to include('<input type="file" name="file">')
    end
  end 
end