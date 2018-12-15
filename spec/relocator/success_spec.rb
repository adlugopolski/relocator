RSpec.describe Relocator::CLI::Success do
  describe "#call" do
    let(:service) { described_class.new(files) }

    context "with no files" do
      let(:files) { [] }

      it "throws an error" do
        expect { service.call }
          .to raise_error Thor::Error, /not found/
      end
    end

    context "with multiple files" do
      let(:files) { %w[file1 file2] }

      it "throws an error" do
        expect { service.call }
          .to raise_error Thor::Error, /file1.*file2/m
      end
    end
  end
end
