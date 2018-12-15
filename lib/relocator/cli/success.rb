# Determines if exactly one matching file was found. If so, it returns
# turth, otherwise it fails with adequate error message.

class Relocator::CLI::Success
  using Relocator::Refinements

  def self.call(*args)
    new(*args).call
  end

  def initialize(files)
    self.files = files
  end

  def call
    case files.length
    when 0
      raise Thor::Error, "Entity definition not found."
    when 1
      true
    else
      raise Thor::Error, multiple_files_error_message.join("\n")
    end
  end

  private

  attr_accessor :files

  def multiple_files_error_message
    [
      "Multiple definitions of entity found.",
      *formatted_files,
    ]
  end

  def formatted_files
    files.map do |name|
      " - %<name>s".format(name: name)
    end
  end
end
