# Redis backed model
class Notice < Ohm::Model
  # Naming module is used so Rails can create RESTful routes
  extend ActiveModel::Naming
  include ActiveModel::Serializers::JSON

  # Boolean state: on or off ("true" or "false" when serialized)
  attribute :status
  reference :user, User
  unique :user_id

  def initialize(*args)
    super

    self.status ||= false
  end

  # Overwrites the user accessor because the Ohm-defined method is not compatible with AciveRecord
  def user
    User.find_by_id(user_id)
  end

  # Ohm method is aliased so we can use our own setter
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

  # Status and user ID must be present
  def validate
    assert_present :status
    assert_present :user_id
  end

  private
    # Converts a status input to a canonical form
    def value_to_status(value)
      case value
      when nil, false, 0, "0", "false"
        false
      else
        true
      end
    end

    def value_to_s(value)
      value_to_status(value) ? :on : :off
    end
end