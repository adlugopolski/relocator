class Relocator::CLI < Thor
  desc "move SOURCE DESTINATION",
       "Move Entity from one location to another"

  def move(src, dst)
    Relocator::CLI::Move.call(src, dst)
  end
end
