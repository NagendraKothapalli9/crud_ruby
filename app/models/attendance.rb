class Attendance < ApplicationRecord
  belongs_to :student
  validates :date,
            uniqueness: {
              scope: :student_id,
              message: "attendance already exists for this student on this date"
            }
  validates :status, presence: true, inclusion: { in: %w[present absent], message: "%{value} is not a valid status" }
end
