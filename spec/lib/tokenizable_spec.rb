require 'rspec'
require_relative '../../lib/tokenizable'


RSpec.describe Tokenizable do

    context "initializing the class" do
      it "should initialize with a string" do
        tokenizable = Tokenizable.new('my-string') 
        expect(tokenizable).to be_a(Tokenizable) 
      end

      it "should return an error if the parameter is not valid" do
        token = 1234
        expect { Tokenizable.new(token)}.to raise_error(RuntimeError)
      end

      it "should not create a var with the parameter" do
        token = 'my-string'
        tokenizable = Tokenizable.new(token)
        expect(tokenizable.string).to be(token)
      end
    end

    context "tokenizing string" do
      context "transaction type" do
        it "should show the correct chars" do
          token = 'r2324'
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_type).to be_nil
        end

        it "should be within 1..9" do
          token = "098282"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_type).to be_nil
        end

        it "should return a string type" do
          token = "567"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_type).to be_a(String)
        end

        it "should reference the correct string" do
          types = [nil, "Débito", "Boleto", "Financiamento", "Crédito", "Recebimento Empréstimo", "Vendas", "Recebimento TED", "Recebimento DOC", "Aluguel"]
          token = ((rand() * 10)).to_s
          expect(Tokenizable.new(token).tokenized_type).to eq(types[token.to_i])
        end
      end

      context "transaction date" do
        let(:token) { "3201903010000014200096206760174753****3153153453" }
        before(:example) { @tokenizable = Tokenizable.new(token) }

        it "should return a valid date" do
          expect(@tokenizable.tokenized_date).to be_a(DateTime)
        end

        it "should have a valid time" do
          expect(@tokenizable.tokenized_date.hour).to be_a(Integer)
          expect(@tokenizable.tokenized_date.minute).to be_a(Integer)
        end
        
        it "should have a valid date" do
          expect(@tokenizable.tokenized_date.year).to be_a(Integer)
          expect(@tokenizable.tokenized_date.day).to be_a(Integer)
        end
      end

      context "transaction amout" do
        let(:token) { "3201903010000014200096206760174753****3153153453" }
        let(:bad_token) {"3201903010000014a00096206760174753****3153153453"}
        before(:example) { @tokenizable = Tokenizable.new(token) }

        it "should have a valid float number" do
          expect(@tokenizable.tokenized_amount).to be_a(Float)
        end

        it "should return nil when is not a valid number" do
          bad_tokenizable = Tokenizable.new(bad_token)
          expect(bad_tokenizable.tokenized_amount).to be_nil
        end

        it "should be a negative number when the type is a outcome" do
          token = "3201903010000014200"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_amount).to be < 0
        end

        it "should be a positive number when the type is a income" do
          token = "6201903010000024200"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_amount).to be > 0
        end
      end

      context "transaction cpf" do
        let(:token) { "3201903010000014200096206760174753****3153153453" }
        before(:example) { @tokenizable = Tokenizable.new(token) }

        it "should have a string with 11 chars" do
          expect(@tokenizable.tokenized_cpf.chars.count).to be(11)
        end

        it "should raise an exception when its chars are not valid" do
          token = "3201903010000014200096a06760174753****3153153453"
          expect(Tokenizable.new(token).tokenized_cpf).to be_nil
        end
      end

      context "transaction credit cards" do
        let(:token) { "3201903010000014200096206760174753****3153153453" }
        let(:bad_token) { "320190301000001420009620676017475RT***3153153453" }
        before(:example) { @tokenizable = Tokenizable.new(token) }

        it "should have a string with 12 chars" do
          expect(@tokenizable.tokenized_credit_card.chars.count).to eq(12)
        end

        it "should have just numbers and * char" do
          bad_tokenizable = Tokenizable.new(bad_token)
          expect(bad_tokenizable.tokenized_credit_card).to be_nil
        end
      end

      context "transaction store owner" do 
        it "should contains a string with 14 chars at maximum" do 
          token = "3201903010000014200096206760174753****3153153453JOÃO MACEDOXXXBAR DO JOÃO"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_store_owner.chars.count).to eq(14)
        end
        
        it "should contains just a string withouts trailing spaces" do 
          token = "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_store_owner.chars.count).to eq(11)
        end
      end
      
      context "transaction store name" do
        it "should contains a string with a 19 chars at maximum" do
          token = "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃOXXXXXXXXX"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_store_name.chars.count).to eq(19)
        end
        
        it "should contains just a string without trailing spaces" do
          token = "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO"
          tokenizable = Tokenizable.new(token)
          expect(tokenizable.tokenized_store_name.chars.count).to eq(11)
        end
      end
    end
    
  
  
end
