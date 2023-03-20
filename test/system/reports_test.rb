# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  Capybara.exact = true
  setup do
    @report = reports(:report1)

    visit root_url
    fill_in 'user_email', with: 'alice@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: '日報のタイトルだよ'
    fill_in '内容', with: '日報の内容だよ'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '日報のタイトルだよ'
    assert_text '日報の内容だよ'
  end

  test 'showing a Report' do
    visit reports_url
    click_on '詳細', match: :first

    assert_text '日報の詳細'
    assert_text 'レポート2のタイトル'
    assert_text 'レポート2の内容'
  end

  test 'updating a Report' do
    visit reports_url
    click_link '編集', match: :first

    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'レポート1のタイトル'
    assert_text 'レポート1の内容'
    click_on '戻る'
  end

  test 'destroying a Report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end
end
