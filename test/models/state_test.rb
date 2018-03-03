require 'test_helper'

class StateTest < ActiveSupport::TestCase
  test 'face should be present' do
    assert_not states(:invalid1).valid?
  end

  test 'x should not be less than 0' do
    plateu = platues(:valid)
    state = State.new(x: -1, y: 0, face: 'N', platue_id: plateu.id)
    assert_not state.save
  end

  test 'y should not be less than 0' do
    plateu = platues(:valid)
    state = State.new(x: 0, y: -1, face: 'N', platue_id: plateu.id)
    assert_not state.save
  end

  test 'should be valid' do
    plateu = platues(:valid)
    assert State.new(x: 1, y: 1, face: 'N', platue_id: plateu.id).valid?
  end
end
