require 'spec_helper'

describe Notice do
  subject do
    new_user = User.new
    new_user.id = -1
    Notice.new(user: new_user)
  end

  it 'should be valid' do
    subject.valid?.should be_true
  end
end
