class Relocator::Support::Underscore
  def self.call(*args)
    new(*args).call
  end

  def initialize(string)
    self.string = string.to_s
  end

  def call
    return string unless /[A-Z-]|::/.match?(string)

    string
      .gsub("::".freeze, "/".freeze)
      .gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
      .gsub(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
      .tr("-".freeze, "_".freeze)
      .downcase
  end

  private

  attr_accessor :string
end
