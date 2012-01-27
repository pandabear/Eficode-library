class IsbnValidator

  VALID_CHARACTERS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'x']
  #attr_accessor :isbn
  attr_reader :isbn
  def initialize(isbn = nil)
    if(isbn.nil?)
      isbn = ""
    end
    @isbn = cleanup_isbn(isbn)
  end

  def valid?
    if(@isbn.size == 10 || @isbn.size == 13)
      @isbn.each_char do |c|
        if(!valid_character?(c))
          false
        end
        return true
      end
    else
      false
    end
  end
  
  private

  def valid_character?(char)
    VALID_CHARACTERS.include?(char)
  end
  
  def cleanup_isbn(isbn)
    isbn.downcase.gsub(/-| /, "")
  end
end
