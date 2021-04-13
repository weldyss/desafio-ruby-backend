require 'rspec'
require_relative '../../lib/file_handling'

RSpec.describe FileHandling do
  context 'initializing class' do
    it "should receive a file string to start" do
      valid = "dir/file.txt"
      expect(FileHandling.new(valid)).to be_a(FileHandling)
    end

    it "should create a file object var" do
      file_var = "dir/file.txt"
      expect(FileHandling.new(file_var).file).to eq(file_var)
    end
  end

  context 'tokenizing file' do
    let(:file) { "../fixtures/file.txt" }
    before(:example) { @file_handling = FileHandling.new(@file) }

    it "should raise error on failing reading file", :pending => "Implementing a file mock was bugging. It will a known issue"
    it "should generate an array with tokenizable strings", :pending => "Implementing a file mock was bugging. It will a known issue"
  end
end