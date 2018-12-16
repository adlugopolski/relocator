RSpec.describe Relocator::CLI::Move do
  describe "#call" do
    let(:service) { described_class.new(src, dst) }
    let(:dst) { "source" }
    let(:src) { "destination" }
    let(:files) { %w[filename] }
    let(:success) { false }

    before do
      allow(Relocator::CLI::Success)
        .to receive_messages(call: success)
      allow(Relocator::CLI::Files)
        .to receive_messages(call: files)
      allow(Relocator::Path::Formatter)
        .to receive_messages(call: "dest")
      allow(Relocator::Path::Spec)
        .to receive_messages(call: "spec")
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
          .exactly(3)
          .times
      end

      it "passed files to success object" do
        expect(Relocator::CLI::Success)
          .to have_received(:call)
          .with(files)
      end

      it "uses spec to determine spec names" do
        expect(Relocator::Path::Spec)
          .to have_received(:call)
          .with("filename")
          .with("dest")
      end
    end
  end
end
