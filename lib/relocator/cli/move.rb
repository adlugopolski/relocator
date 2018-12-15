class Relocator::CLI::Move
  using Relocator::Refinements

  def self.call(*args)
    new(*args).call
  end

  def initialize(src, dst)
    self.src = src
    self.dst = dst
  end

  def call
    return unless Relocator::CLI::Success.call(files)
  end

  private

  attr_accessor :src, :dst

  def class_name_regexp
    "class %<name>s"
      .format(name: src)
      .yield_self { |string| Regexp.escape(string) }
      .yield_self { |regexp| Regexp.new(regexp) }
  end

  def files
    @_files ||=
      Dir["**/*.rb"].reject do |filename|
        File
          .open(filename)
          .grep(class_name_regexp)
          .empty?
      end
  end
end
