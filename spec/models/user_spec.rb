require 'rails_helper'

RSpec.describe User, type: :model do
  let(:default_password) {"123123123"}
  let(:user) { create(:user , password: default_password)}

  context 'validate username' do 
    subject do 
      described_class.new({
        username: "admin123",
        password: default_password,
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
end
