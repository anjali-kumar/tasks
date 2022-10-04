class User < ApplicationRecord
    validates :username, presence: true, length: { minimum: 4 }
    validates :birthdate, presence: true
    # before_save :validate_password
    validate :validate_password, on: [:create, :update]
    validate :verify_age, on: [ :create, :update]

    has_secure_password

    private
    def validate_password
        if password == username
            errors.add(:invalid_password, 'password should not match username')
        end
    end

    def verify_age
        if birthdate && birthdate > 18.years.ago
            errors.add(:birthdate, 'Age should be greater than 18 years')
        end
    end
end
