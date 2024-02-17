class User < ApplicationRecord
  has_many :enrollments
  has_many :teachers, through: :enrollments
  enum kind: {student: 0, teacher: 1, student_teacher: 2}

  def self.classmates(user)
    classmates_ids = Enrollment.joins(:program)
                               .where(programs: { id: user.enrollments.select(:program_id) })
                               .where.not(user_id: user.id)
                               .distinct
                               .pluck(:user_id)
  
    User.where(id: classmates_ids)
  end
end
