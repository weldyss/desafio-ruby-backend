require 'sinatra/base'
require 'sinatra/activerecord'
require_relative './models/transaction'
require_relative './lib/file_handling'
require_relative './lib/tokenizable'


class App < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/upload' do
    @filename = params[:file][:tempfile]
    puts params[:file][:tempfile]
    content = FileHandling.new(@filename)
    content.tokenize_file.each do |line|
      token = Tokenizable.new(line)
      Transaction.create(
        transaction_type: token.tokenized_type,
        transacted_at: token.tokenized_date,
        amount: token.tokenized_amount,
        cpf: token.tokenized_cpf,
        credit_card: token.tokenized_credit_card,
        store_owner: token.tokenized_store_owner,
        store_name: token.tokenized_store_name
      )
    end
    "Uploaded!"
  end

  get '/report' do
    @transactions = Transaction.all
    erb :report
  end
end