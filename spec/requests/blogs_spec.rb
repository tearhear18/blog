require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user){ create(:user)}
  let(:auth){ user.generate_access_token }
  
  describe "GET /create" do
    subject do 
      post blogs_path(params),
            as: :json,
            headers: {
              HTTP_AUTHORIZATION: "Bearer token=#{auth.token}"
            }
    end

    let(:params) { {title: "Blog Title", body: "Blog Body"} }

    before { subject }

    it do 
      expect(response).to have_http_status(:ok)
      res = response.parsed_body
      expect(res.keys).to eq(["message", "blog"])
    end

  end
end
