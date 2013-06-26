require 'spec_helper'

describe User do
  subject do
    User.new(email: 'scottadams@aol.com', password: 'dilbert13')
  end

  it {should be_valid}
end
