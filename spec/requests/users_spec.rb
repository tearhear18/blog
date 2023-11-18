require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user){ create(:user)}

  describe "POST /create" do
    subject { post users_path( params), as: :json }
    
    context "creating valid account" do 
      let(:params) { {user:{username: "admin123", password:"123123123"}} }

      before { subject }
      it do 
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /login" do
    subject { post login_users_path( params), as: :json }
    
    context "creating valid account" do 
      let(:params) { {user:{username: user.username, password: user.password}} }

      before { subject }
      it do 
        expect(response).to have_http_status(:ok)
        res = response.parsed_body
        expect(res.keys).to eq(["message", "access_token"])
      end
    end
  end
end
