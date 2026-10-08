class Student < ApplicationRecord
    belongs_to :school
    has_many :attendances, dependent: :destroy
    has_secure_password
    has_one_attached :profile_picture
    
   validates :name, presence: true, format: {
  with: /\A[A-Za-z]+(?: [A-Za-z]+)*\z/,
  message: "can contain only letters and spaces"
}
  validates :email, presence: true, uniqueness: true, format: {
  with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/,
  message: "must be a valid email address"
}
  validates :password, presence: true, on: :create, format: {
    with: /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}\z/,
    message: "must be at least 8 characters and contain uppercase, lowercase, number, and symbol"
  }
  validates :age,
  presence: true,
  numericality: {
    only_integer: true,
    greater_than_or_equal_to: 18
  }
  validates :course,
  presence: true,
  format: {
  with: /\A[A-Za-z0-9]+\z/,
  message: "can contain only letters or numbers"
}
end
