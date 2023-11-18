require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user)}

  context 'validate username' do 
    subject do 
      described_class.new({
        username: "admin123",
        password: "123123123",
      })
    end

    it "when valid username" do 
      expect(subject).to be_valid
    end

    it "when empty" do 
      subject.username = nil 
      expect(subject).not_to be_valid
    end

    it "when invalid" do 
      subject.username = user.username 
      expect(subject).not_to be_valid
    end

    it "when less than 6" do 
      subject.username = "u"*5
      expect(subject).not_to be_valid
    end
    it "when more than 20" do 
      subject.username = "u"*25
      expect(subject).not_to be_valid
    end
  end

  context "when validating password" do 
    it "when empty" do 
      subject.password = nil 
      expect(subject).not_to be_valid
    end

    it "when less than 6" do 
      subject.password = "p"*5
      expect(subject).not_to be_valid
    end
    it "when more than 50" do 
      subject.password = "p"*55
      expect(subject).not_to be_valid
    end
  end

  context "user authenticate" do 
    subject { user.authenticate password }
    
    context "with valid account" do 
      let(:password) {user.password}

      it { is_expected.to be_truthy }
    end

    context "with invalid account" do 
      let(:password) {"111111111"}

      it { is_expected.to be_falsy }
    end
  end

  context "user generate_access_token" do 
    subject { user.generate_access_token }

    it{ is_expected.to be_truthy}
  end
end
