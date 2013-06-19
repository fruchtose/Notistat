class Notice < Ohm::Model
  extend ActiveModel::Naming

  attribute :status
  reference :user, User
  unique :user_id

  def user
    User.find_by_id(user_id)
  end

  alias_method :old_status=, :status=
  def status=(value)
    value = value_to_status(value)
    send(:old_status=, value)
  end

  alias_method :old_status, :status
  def status
    value_to_status(old_status)
  end

  def to_s
    "#{value_to_s(status)}"
  end

  def validate
    assert_present :status
    assert_present :user_id
  end

  private
    def value_to_status(value)
      case value
      when nil, false, 0
        false
      else
        value.to_i != 0
      end
    end

    def value_to_s(value)
      value_to_status(value) ? :on : :off
    end
end