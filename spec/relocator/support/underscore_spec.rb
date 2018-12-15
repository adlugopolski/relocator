RSpec.describe Relocator::Support::Underscore do
  describe "#call" do
    let(:service) { described_class.new(string) }

    context "with simple entity name" do
      let(:string) { "UserName" }

      it "returns underscored version" do
        expect(service.call).to eq "user_name"
      end
    end

    context "with namespaced entity name" do
      let(:string) { "BigParent::UserName::Regexp" }

      it "returns underscored version" do
        expect(service.call).to eq "big_parent/user_name/regexp"
      end
    end

    context "with empty input" do
      let(:string) { "" }

      it "returns underscored version" do
        expect(service.call).to eq ""
      end
    end
  end
end
