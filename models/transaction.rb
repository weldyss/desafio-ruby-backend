require 'sinatra/activerecord'

class Transaction < ActiveRecord::Base

  validates_presence_of :transaction_type,
                        :transacted_at,
                        :amount,
                        :cpf,
                        :credit_card,
                        :store_owner,
                        :store_name, on: :create, message: "can't be blank"
                      
end