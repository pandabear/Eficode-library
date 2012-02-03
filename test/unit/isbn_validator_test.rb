require 'test_helper'

class IsbnValidatorTest < ActiveSupport::TestCase

  test "an ISBN with dashes is valid" do
    v = IsbnValidator.new.valid?("951-98548-9-4")
    assert v
  end
  
  test "an ISBN with whitespaces in between the digits is a valid ISBN" do
    v = IsbnValidator.new.valid?("951 98548 9 4")
    assert v
  end
  
  test "An empty string is not a valid ISBN" do
    v = IsbnValidator.new.valid?("")
    assert !v
  end
  
  test "Letters other than X is NOT a valid ISBN" do
    v = IsbnValidator.new.valid?("951-98548-9-p")
    assert !v
  end
  
  test "A string with 14 digits is not valid" do
    v = IsbnValidator.new.valid?("01234567891234")
    assert !v
  end

end
