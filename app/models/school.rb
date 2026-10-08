class School < ApplicationRecord
  has_many :school_admins, dependent: :destroy
  has_many :students, dependent: :destroy
  accepts_nested_attributes_for :school_admins

   validates :name, presence: true, format: {
  with: /\A[A-Za-z]+(?: [A-Za-z]+)*\z/,
  message: "can contain only letters and spaces"
}
 
end