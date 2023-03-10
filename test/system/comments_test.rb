# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  Capybara.exact = true
  setup do
    @report = reports(:report1)

    visit root_url
    fill_in 'user_email', with: 'alice@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'ログイン'
  end

  test 'creating a Comment' do
    visit reports_url
    click_on '詳細', match: :first

    fill_in 'comment_content', with: '日報のコメントだよ'
    click_on 'コメントする'

    assert_text 'コメントが投稿されました。'
    assert_text '日報のコメントだよ'
  end
end
