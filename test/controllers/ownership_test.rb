require 'test_helper'

class OwnershipTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @owner = User.create!(email: 'owner@example.com', password: 'password123')
    @other = User.create!(email: 'other@example.com', password: 'password123')
    @post = @owner.posts.create!(title: 'Original post')
    @article = @owner.articles.create!(title: 'Original article')
    sign_in @other
  end

  test 'another user cannot update or delete a post' do
    patch post_path(@post), params: { post: { title: 'Changed' } }
    assert_redirected_to posts_path
    assert_equal 'Original post', @post.reload.title

    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to posts_path
  end

  test 'another user cannot update or delete an article' do
    patch article_path(@article), params: { article: { title: 'Changed' } }
    assert_redirected_to articles_path
    assert_equal 'Original article', @article.reload.title

    assert_no_difference 'Article.count' do
      delete article_path(@article)
    end
    assert_redirected_to articles_path
  end
end
