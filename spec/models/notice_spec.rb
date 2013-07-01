require 'spec_helper'

describe Notice do
  subject do
    new_user = User.new
    new_user.id = -1
    Notice.new(user: new_user)
  end

  context 'when untouched' do
    it 'should have no status' do
      subject.status.should be_false
      subject.to_s.should == 'off'
    end
  end

  context 'when turned on' do
    it 'should have status' do
      subject.status = true
      subject.status.should be_true
      subject.to_s.should == 'on'
    end
  end

  it 'should be valid' do
    subject.valid?.should be_true
  end
end
