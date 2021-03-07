class User < ApplicationRecord
    has_many :rests, dependent: :destroy
end
