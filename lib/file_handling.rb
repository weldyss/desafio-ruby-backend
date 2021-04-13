class FileHandling 

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def tokenize_file
    tokens = File.readlines(@file)
    rescue Errno::ENOENT
    tokens
  end
end