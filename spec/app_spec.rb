require_relative '../app'
require_relative '../models/transaction'
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
      expect(last_response.body).to include("Para gerar o relatório, envie o arquivo no form abaixo")
    end

    it "render the form to upload file" do
      expect(last_response.body).to include('<input type="file" name="file">')
    end
  end

  describe "POST #upload" do
    
    it "should resolve the uploaded page" do
      post "/upload", {:file =>{:filename=>"CNAB.txt"}}
      expect(last_response.body).to include("Uploaded")
    end

    it "should call the transaction to save on database" do
      pending("Uploading files is a known issue there")
      count = Transaction.count
      post "/upload", {:file =>{:filename=>"./fixtures/CNAB.txt"}}
      expect(Transaction.count).not_to eq(count)
    end
  end

  describe "GET #report" do

    before(:example) { Transaction.delete_all }

    it "should show the report from data" do
      get '/report'
      expect(last_response.body).to include("Lista de todos as transações")
    end

    it "should show the amount sum"
  end
end