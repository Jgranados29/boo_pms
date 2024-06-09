class User < ApplicationRecord
    has_many :assignments
    has_many :tasks, through: :assignments
    has_many :memberships
    has_many :teams, through: :memberships
end
