class User < ApplicationRecord
    has_many :projects
    
    validates :username, presence: true, length: { minimum: 4 }
    validates :birthdate, presence: true

    validate :validate_password, on: [:create, :update]
    validate :verify_age, on: [ :create, :update]

    has_secure_password
    has_secure_token :auth_token

    AUTH_TOKEN_VALIDITY = 1.minute

    # def update_auth_token
    #     auth_token_created_at = Time.now
    #     regenerate_auth_token
    # end

    def valid_token?
        auth_token_created_at + AUTH_TOKEN_VALIDITY > (Time.now)
    end

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
