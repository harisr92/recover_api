require 'test_helper'

class PlatueTest < ActiveSupport::TestCase
  test 'invalid width less than 1' do
    assert_not platues(:invalid1).valid?
  end

  test 'invalid height less than 1' do
    assert_not platues(:invalid2).valid?
  end
end
