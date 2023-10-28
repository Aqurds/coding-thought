require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_numericality_of(:commentsCounter).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:likesCounter).only_integer.is_greater_than_or_equal_to(0) }
end
