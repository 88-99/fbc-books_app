# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:Alice)
    @bob = users(:Bob)
  end

  test '#name_or_email' do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end

  test 'フォローする' do
    assert_equal @bob.active_relationships.find_or_create_by!(following_id: @alice.id), @bob.follow(@alice)
  end

  test 'フォローを解除する' do
    relationship = @bob.active_relationships.find_by(following_id: @alice)
    assert_equal relationship&.destroy!, @bob.unfollow(@alice)
  end

  test 'ユーザをフォローしているかどうか' do
    assert_equal @bob.active_relationships.where(following_id: @alice.id).exists?, @bob.following?(@alice)
  end

  test 'ユーザにフォローされているかどうか' do
    assert_equal @bob.passive_relationships.where(follower_id: @alice.id).exists?, @bob.followed_by?(@alice)
  end
end
