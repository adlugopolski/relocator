class Relocator::Path::Spec
  def self.call(*args)
    new(*args).call
  end

  def initialize(string)
    self.string = string
  end

  def call
    string
      .split("/")
      .yield_self(&replace)
      .join("/")
  end

  private

  attr_accessor :string

  def replace
    Proc.new do |parts|
      [
        "spec",
        *parts[1..-2],
        parts[-1].gsub(".rb", "_spec.rb")
      ]
    end
  end
end
