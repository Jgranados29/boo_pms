class Task < ApplicationRecord
    include AASM
    aasm column: 'status' do
        state :pending, initial: true
        state :in_progress, :completed

        event :start do
            transitions from: :pending, to: :in_progress
            before do
                self.started_at = Time.now
            end
        end

        event :complete do
            transitions from: :in_progress, to: :completed
            before do
                self.completed_at = Time.now
            end
        end

        def may_start?
            pending?
        end
    end
    has_many :assignments
    has_many :users, through: :assignments

    validates :title, presence: true
    validates :description, presence: true
    validates :due_date, presence: true

    before_save :set_default_values

    private

    def set_default_values
        self.started_at ||= Time.now if in_progress?
        self.completed_at ||= Time.now if completed?
    end
end
