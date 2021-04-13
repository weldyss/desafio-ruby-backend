require 'rspec'
require_relative '../../models/transaction'

RSpec.describe Transaction do
  context "validations" do 
    let(:transaction) { Transaction.new(
                                        transaction_type: 'Despesa',
                                        transacted_at: DateTime.now,
                                        amount: 45.05,
                                        cpf: '00100200345',
                                        credit_card: '23452345****9899', 
                                        store_owner: 'owner of the store',
                                        store_name: 'name of the store'
                        ) }

    it "should validates presence of type" do 
      transaction.transaction_type = nil
      expect(transaction).not_to be_valid
    end

    it "should validates presence of transacted_at" do 
      transaction.transacted_at = nil
      expect(transaction).not_to be_valid
    end

    it "should validates presence of amount" do 
      transaction.amount = nil
      expect(transaction).not_to be_valid
    end

    it "should validates presence of cpf" do 
      transaction.cpf = nil
      expect(transaction).not_to be_valid
    end

    it "should validates presence of credit_card" do 
      transaction.credit_card = nil
      expect(transaction).not_to be_valid
    end

    it "should validates presence of store_owner" do 
      transaction.store_owner = nil
      expect(transaction).not_to be_valid
    end

    it "should validates presence of store_name" do 
      transaction.store_name = nil
      expect(transaction).not_to be_valid
    end
  end
end