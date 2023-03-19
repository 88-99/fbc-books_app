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
    Relationship.destroy_all
    @alice.follow(@bob)
    assert Relationship.first.follower.id == @alice.id && Relationship.first.following.id == @bob.id
  end

  test 'フォローを解除する' do
    @alice.unfollow(@bob)
    assert Relationship.all.blank?
  end

  test 'ユーザをフォローしている' do
    assert @alice.following?(@bob)
  end

  test 'ユーザをフォローしていない' do
    assert_not @bob.following?(@alice)
  end

  test 'ユーザにフォローされている' do
    assert @bob.followed_by?(@alice)
  end

  test 'ユーザにフォローされていない' do
    assert_not @alice.followed_by?(@bob)
  end
end
