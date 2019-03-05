RSpec.describe Relocator::CLI::Move do
  describe "#call" do
    let(:service) { described_class.new(src, dst) }
    let(:dst) { "source" }
    let(:src) { "destination" }
    let(:files) { %w[dir1/file1 dir2/file2] }
    let(:success) { false }

    before do
      allow(Relocator::CLI::Success)
        .to receive_messages(call: success)
      allow(Relocator::CLI::Files)
        .to receive_messages(call: files)
      allow(Relocator::Path::Formatter)
        .to receive_messages(call: "dest/file1.rb")
      allow(Relocator::Path::Spec)
        .to receive_messages(call: "spec/file1_spec.rb")
      allow(STDOUT).to receive(:puts)

      service.call
    end

    context "with no success" do
      let(:success) { false }

      it "does not output commands" do
        expect(STDOUT).not_to have_received(:puts)
      end
    end

    context "with data found" do
      let(:success) { true }

      it "outputs commands" do
        expect(STDOUT)
          .to have_received(:puts)
          .with("mkdir -p dest")
          .with("mkdir -p spec")
          .with("mv dir1/file1 dest/file1.rb")
          .with("mv spec/file1_spec.rb spec/file1_spec.rb")
          .with(
            "gsed -i 's/destination/source/g' dest/file1.rb spec/file1_spec.rb"
          )
      end

      it "passed files to success object" do
        expect(Relocator::CLI::Success)
          .to have_received(:call)
          .with(files)
      end

      it "uses spec to determine spec names" do
        expect(Relocator::Path::Spec)
          .to have_received(:call)
          .with("dest/file1.rb")
          .with("dir1/file1")
      end
    end
  end
end
