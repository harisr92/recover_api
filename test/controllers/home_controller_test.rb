require 'test_helper'
require 'pry'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should creates platue' do
    assert_difference('Platue.count') do
      post root_url, params: { plateau: '5 5', state: '3 2 N', move: 'LMM' }
    end
    json = JSON.parse(response.body)
    assert_equal 'Success', json['message']
    assert_equal '1 2 W', json['state']
  end

  test 'should creates states' do
    assert_difference('State.count') do
      post root_url, params: { plateau: '5 5', state: '3 2 N', move: 'LMM' }
    end
  end

  test 'output validation' do
    post root_url, params: { plateau: '5 5', state: '1 2 N', move: 'LMLMLMLMM' }
    json = JSON.parse(response.body)
    assert_equal '1 3 N', json['state']
    post root_url, params: { state: '3 3 E', move: 'MMRMMRMRRM' }
    json = JSON.parse(response.body)
    assert_equal '5 1 E', json['state']
  end

  test 'should get state' do
    post root_url, params: { plateau: '5 5', state: '1 2 N', move: 'LMLMLMLMM' }
    json = JSON.parse(response.body)
    get root_url, params: { plateau_id: json['plateau'] }
    json = JSON.parse(response.body)
    assert_equal '1 3 N', json['state']
  end

  test 'should destroy platue' do
    post root_url, params: { plateau: '5 5', state: '1 2 N', move: 'LMLMLMLMM' }
    json = JSON.parse(response.body)
    assert_difference('Platue.count', -1) do
      delete root_path, params: { plateau_id: json['plateau'] }
    end
  end
end
