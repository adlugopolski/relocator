class Relocator::CLI::Move
  using Relocator::Refinements

  def self.call(*args)
    new(*args).call
  end

  def initialize(source_class_name, dest_class_name)
    self.source_class_name = source_class_name
    self.dest_class_name = dest_class_name
  end

  def call
    return unless Relocator::CLI::Success.call(files)

    STDOUT.puts "mv %s %s".format(code_source, code_dest)
    STDOUT.puts "mv %s %s".format(spec_source, spec_dest)
    STDOUT.puts replace_command
  end

  private

  attr_accessor :source_class_name, :dest_class_name

  def replace_command
    "gsed -i 's/%s/%s/g' %s %s".format(
      source_class_name,
      dest_class_name,
      code_dest,
      spec_dest,
    )
  end

  def files
    @_files ||= Relocator::CLI::Files.call(source_class_name)
  end

  def code_source
    files.first
  end

  def spec_source
    Relocator::Path::Spec.call(code_source)
  end

  def code_dest
    @_code_dest ||= Relocator::Path::Formatter.call(dest_class_name, code_source)
  end

  def spec_dest
    @_spec_dest ||= Relocator::Path::Spec.call(code_dest)
  end
end
