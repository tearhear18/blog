require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user){ create(:user)}
  let(:auth){ user.generate_access_token }
  let!(:blogs){ create_list(:blog_content, 5, user: user) }

  describe "GET /index" do
    subject do 
      get blogs_path,
            as: :json,
            headers: {
              HTTP_AUTHORIZATION: "Bearer token=#{auth.token}"
            }
    end

    before { subject }

    it do 
      expect(response).to have_http_status(:ok)
      res = response.parsed_body
      expect(res["blogs"].size).to eq(5)
      expect(res["blogs"].first.keys).to eq(["id", "title", "body"])
    end
  end

  describe "POST /create" do
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
      expect(res["blog"].keys).to eq(["id", "title", "body"])
    end
  end

  describe "GET /show" do
    subject do 
      get blog_path(params),
            as: :json,
            headers: {
              HTTP_AUTHORIZATION: "Bearer token=#{auth.token}"
            }
    end

    let(:params){{id: blogs.pluck(:id).sample}}

    before { subject }
    it do 
      expect(response).to have_http_status(:ok)
      res = response.parsed_body
      expect(res.keys).to eq(["message", "blog"])
      expect(res["blog"].keys).to eq(["id", "title", "body"])
    end

  end

  describe "PATCH  /update" do 
    subject do 
      patch blog_path(params),
            as: :json,
            headers: {
              HTTP_AUTHORIZATION: "Bearer token=#{auth.token}"
            }
    end

    let(:params){{id: blogs.pluck(:id).sample, title: "Updated Title", body: "Updated Body"}}

    before { subject }
    it do 
      expect(response).to have_http_status(:ok)
      res = response.parsed_body
      expect(res.keys).to eq(["message", "blog"])
      expect(res["blog"]["title"]).to eq("Updated Title")
      expect(res["blog"]["body"]).to eq("Updated Body")
    end
  end

  describe "DELETE  /destroy" do 
    subject do 
      delete blog_path(params),
            as: :json,
            headers: {
              HTTP_AUTHORIZATION: "Bearer token=#{auth.token}"
            }
    end

    let(:params){{id: blogs.pluck(:id).sample}}

    before { subject }
    it do 
      expect(response).to have_http_status(:ok)
      expect(user.blog_contents.count).to eq(4)
    end
  end

  describe "GET  /search" do 
    subject do 
      get search_blogs_path(params),
            as: :json,
            headers: {
              HTTP_AUTHORIZATION: "Bearer token=#{auth.token}"
            }
    end

    before do 
      user.blog_contents.create title: "Searchable", body: "Hello World! How wonderful it is"
    end  
    
    context "search with 1 result" do 
      before { subject }
      let(:params){{q: "world"}}

      it do 
        expect(response).to have_http_status(:ok)
        res = response.parsed_body
        expect(res["blogs"].size).to eq(1)
      end
    end

    context "search with multiple results" do 
      before { subject }
      let(:params){{q: "title"}}

      it do 
        expect(response).to have_http_status(:ok)
        res = response.parsed_body
        expect(res["blogs"].size).to eq(5)
      end
    end

    context "search with multiple results" do 
      before { subject }
      let(:params){{q: "asdsad"}}

      it do 
        expect(response).to have_http_status(:ok)
        res = response.parsed_body
        expect(res["blogs"].size).to eq(0)
      end
    end
  end
  
end
