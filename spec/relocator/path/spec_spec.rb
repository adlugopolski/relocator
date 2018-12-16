RSpec.describe Relocator::Path::Spec do
  describe "#call" do
    let(:service) { described_class.new(string) }

    context "with typical longer rails path" do
      let(:string) { "app/service/user/support/locker.rb" }

      it "generates spec path" do
        expect(service.call)
          .to eq "spec/service/user/support/locker_spec.rb"
      end
    end

    context "with typical shorter rails path" do
      let(:string) { "app/form/user_form.rb" }

      it "generates spec path" do
        expect(service.call)
          .to eq "spec/form/user_form_spec.rb"
      end
    end

    xcontext "with lib path" do
      let(:string) { "lib/user/support/locker.rb" }

      it "generates spec path" do
        expect(service.call)
          .to eq "spec/lib/user/support/locker_spec.rb"
      end
    end
  end
end
