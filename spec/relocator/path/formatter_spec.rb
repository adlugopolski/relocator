RSpec.describe Relocator::Path::Formatter do
  describe "#call" do
    let(:service) { described_class.new(output, filename) }
    let(:filename) { "app/service/user/name_formatter.rb" }

    context "with valid name" do
      let(:output) { "User::Name::Formatter" }

      it "outputs new location for name formatter" do
        expect(service.call).to eq "app/service/user/name/formatter.rb"
      end
    end

    context "with valid complex name" do
      let(:output) { "User::Support::NameFormatter" }

      it "outputs new location for name formatter" do
        expect(service.call)
          .to eq "app/service/user/support/name_formatter.rb"
      end
    end

    context "with short path" do
      let(:output) { "Subdomain::AdminDomain" }
      let(:filename) { "lib/subdomain.rb" }

      it "outputs new location for name formatter" do
        expect(service.call)
          .to eq "lib/subdomain/admin_domain.rb"
      end
    end

    context "with complex short path" do
      let(:output) { "Subdomain::Admin::Domain" }
      let(:filename) { "lib/subdomain/admin_domain.rb" }

      xit "outputs new location for name formatter" do
        expect(service.call)
          .to eq "lib/subdomain/admin_domain.rb"
      end
    end
  end
end
