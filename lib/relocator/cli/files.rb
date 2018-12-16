class Relocator::CLI::Files
  def self.call(*args)
    new(*args).call
  end

  def initialize(class_name, glob: "**/*.rb")
    self.class_name = class_name
    self.glob = glob
  end

  def call
    Dir[glob].reject do |filename|
      File
        .open(filename)
        .grep(class_name_regexp)
        .empty?
    end
  end

  private

  attr_accessor :glob, :class_name

  def class_name_regexp
    class_name
      .yield_self { |string| Regexp.escape(string) }
      .yield_self { |regexp| Regexp.new(/(class|module) #{regexp}/) }
  end
end
