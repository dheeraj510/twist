require 'spec_helper'

describe BooksController do
  before do
    # Needs to exist (and have called Resque.enqueue) before we trigger the post-receive hook
    @book = FactoryGirl.create(:book)
  end
  
  it "post-receive hooks" do
    Book.should_receive(:find_by).and_return(@book)
    @book.should_receive(:enqueue)
    post :receive, :id => @book.permalink
  end
end
