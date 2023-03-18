# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:Alice)
    @bob = users(:Bob)
    Relationship.destroy_all
    @alice.follow(@bob)
  end

  test '#name_or_email' do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end

  test 'フォローする' do
    assert Relationship.first.follower.id == @alice.id && Relationship.first.following.id == @bob.id
  end

  test 'フォローを解除する' do
    @alice.unfollow(@bob)
    assert Relationship.all.blank?
  end

  test 'ユーザをフォローしているかどうか' do
    assert @alice.following?(@bob)
  end

  test 'ユーザにフォローされているかどうか' do
    assert @bob.followed_by?(@alice)
  end
end
