require 'date'

class Tokenizable

  attr_reader :string

  def initialize(string)
    string.is_a?(String) ? @string = string : raise { Exception.new(RuntimeError) }
  end

  def tokenized_type
    type = self.tokenize_type
    case type
    when 1
      "Débito"
    when 2
      "Boleto"
    when 3
      "Financiamento"
    when 4
      "Crédito"
    when 5
      "Recebimento Empréstimo"
    when 6
      "Vendas"
    when 7
      "Recebimento TED"
    when 8
      "Recebimento DOC"
    when 9
      "Aluguel"
    else
      nil
    end
  end
  
  def tokenized_date
    date         = @string.slice(1,8).strip
    time         = @string.slice(42,6).strip
    DateTime.strptime(date + time, "%Y%m%d%H%M%S")
  end
  
  def tokenized_amount
    amount_string = @string.slice(9,10).strip
    if amount_string.to_i.to_s.rjust(10, '0') == amount_string
      amount = (amount_string.to_f) / 100
      case self.tokenize_type
      when 2
        amount *= -1
      when 3
        amount *= -1
      when 9
        amount *= -1
      else
        amount
      end
    else 
      nil
    end
  end
  
  def tokenized_cpf
    string = @string.slice(19,11).strip
    string.each_char do |char|
      return nil unless char.to_i.to_s == char
    end
  end

  def tokenized_credit_card
    string = @string.slice(30,12).strip
    string.each_char do |char|
      return nil unless char.to_i.to_s == char || char == '*'
    end
  end

  def tokenized_store_owner
    @string.slice(48,14).strip
  end

  def tokenized_store_name
    @string.slice(62,19).strip
  end

  private 

  def tokenize_type
    @string.slice(0,1).strip.to_i
  end
end