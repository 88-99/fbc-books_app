# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?(target_user)' do
    alice = User.find_by(name: 'Alice')
    bob = User.find_by(name: 'Bob')
    report = Report.new(user_id: alice.id, title: '日報のタイトル', content: '日報の内容')

    assert report.editable?(alice)
    assert_not report.editable?(bob)
  end

  test '#created_on' do
    report = Report.new(created_at: Time.current, title: '日報のタイトル', content: '日報の内容')
    assert_equal Time.current.to_date, report.created_on
  end
end
