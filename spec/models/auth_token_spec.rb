require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe AuthToken, type: :model do
    let(:user) { create(:user)}
    let(:token) { {token: "AA"* 50}}

    context 'new token' do 
        subject { user.auth_tokens.new token}
        it{is_expected.to be_truthy}
    end

    context 'validate expiration' do 
        subject { user.auth_tokens.create token}

        context 'when valid' do 
            it{ expect(subject.active?).to be_truthy}
        end

        context 'when expired' do 
            before do 
                subject
                travel(61.minutes)
            end
            it{ expect(subject.expired?).to be_truthy}
        end
    end
end