class Relocator::Path::Formatter
  def self.call(*args)
    new(*args).call
  end

  def initialize(output, filename)
    self.output = output
    self.filename = filename
  end

  def call
    Pathname
      .new("")
      .join(*parts, output_underscore)
      .sub_ext(".rb")
      .to_s
  end

  private

  attr_accessor :output, :filename

  def parts
    filename.split("/", 3)[0..-2]
  end

  def output_underscore
    Relocator::Support::Underscore.call(output)
  end
end
