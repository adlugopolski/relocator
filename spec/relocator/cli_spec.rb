RSpec.describe Relocator::CLI do
  describe "Parent" do
    let(:service) { described_class.new }

    it "inherites from Thor" do
      expect(service).to be_kind_of Thor
    end
  end

  describe "#move" do
    let(:service) { described_class.new }

    before do
      allow(Relocator::CLI::Move).to receive(:call)
    end

    it "forward the call to Move object" do
      service.move(:src, :dst)

      expect(Relocator::CLI::Move)
        .to have_received(:call)
        .with(:src, :dst)
    end
  end
end
