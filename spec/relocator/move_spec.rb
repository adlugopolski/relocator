RSpec.describe Relocator::CLI::Move do
  describe "#call" do
    let(:service) { described_class.new(src, dst) }
    let(:dst) { "source" }
    let(:src) { "destination" }
    let(:files) { [] }
    let(:success) { false }

    before do
      allow(Relocator::CLI::Success).to receive_messages(call: success)
      allow(Dir).to receive_messages("[]": files)
    end

    context "without any files" do
      it "returns nothing" do
        expect(service.call).to be_nil
      end
    end

    context "with one present file" do
      let(:files) { %w[spec/support/data/some_file.rb] }

      xit "does peform rename" do
        service.call
      end
    end

    context "with two present files" do
      let(:files) do
        %w[
          spec/support/data/some_file.rb
          spec/support/data/other_file.rb
        ]
      end

      xit "returns nothing" do
        expect(service.call).to be_nil
      end
    end
  end
end
