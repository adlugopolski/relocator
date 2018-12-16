RSpec.describe Relocator::CLI::Files do
  describe "#call" do
    let(:class_name) { "Someclass::Data" }
    let(:service) { described_class.new(class_name, glob: glob) }

    context "with no files" do
      let(:glob) { "spec/support/data/something/*" }

      it "returns nothing" do
        expect(service.call).to eq []
      end
    end

    context "with matching files" do
      let(:glob) { "spec/support/data/*" }

      it "returns matching gile" do
        expect(service.call)
          .to eq %w[spec/support/data/someclass_data.rb]
      end
    end

    context "with no parameter" do
      let(:service) { described_class.new(class_name) }

      before do
        allow(Dir).to receive_messages("[]": [])

        service.call
      end

      it "uses default **/*.rb" do
        expect(Dir)
          .to have_received("[]")
          .with("**/*.rb")
      end
    end
  end
end
