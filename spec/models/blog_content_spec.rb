require 'rails_helper'

RSpec.describe BlogContent, type: :model do
  let(:default_password) {"123123123"}
  let(:user) { create(:user , password: default_password)}

  context 'new blog' do 
    subject do 
      described_class.new({
        user: user,
        title: "New Title",
        body: "New Body"
      })
    end
    it { is_expected.to be_valid }
    it { is_expected.to be_truthy }
  end

  context 'create blog' do 
    subject do 
      described_class.create({
        user: user,
        title: "New Title",
        body: "New Body"
      })
    end
    it { is_expected.to be_truthy }
    it do 
      subject.reload
      expect(described_class.count).to eq(1)
    end
  end

  context 'update blog' do 
    let(:blog) { create(:blog_content, user: user)}
    subject do 
      described_class.find(blog.id).update({
        title: "Update Title",
        body: "Update Body"
      })
    end
    before { subject }
    it { is_expected.to be_truthy }
    it do 
      blog.reload
      expect(blog.title).to eq("Update Title")
      expect(blog.body).to eq("Update Body")
    end
  end

  context 'delete blog' do 
    let(:blog) { create(:blog_content, user: user)}
    subject do 
      described_class.find(blog.id).delete
    end
    before { subject }
    it { is_expected.to be_truthy }
    it { expect(described_class.count).to eq(0) }
  end

end
