require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  
  test "book listing" do
    get :index
    assert_response :success
    assert assigns(:books)
  end
  
  test "book listing in XML" do
    get :index, format: :xml
    assert_response :success
  end
  
  test "show book" do
    get :show, id: books(:steppenwolf).id

    assert_response :success
    assert assigns(:book)
    assert_equal assigns(:book), books(:steppenwolf)
  end
  
  test "new book" do
    get :new
    assert_response :success
    assert assigns(:book)
    assert assigns(:book).new_record?
  end
  
  test "create book with valid parameters" do
    post :create, book: {title: 'Programming Your Home', authors: 'Mike Riley', isbn: '978-1-93435-690-6'}
    assert_response :redirect
    assert_redirected_to books_path
    assert flash[:notice]
  end

  test "create book with invalid parameters" do
    post :create, book: {title: 'No such book'}
    assert_response :success
    assert assigns(:book)
    assert assigns(:book).new_record?
    assert_template :new
  end
  
  test "edit book" do
    get :edit, id: books(:steppenwolf).id

    assert_response :success
    assert assigns(:book)
    assert_equal assigns(:book), books(:steppenwolf)
  end

  test "update book with valid parameters" do
    put :update, id: books(:steppenwolf).id,
                 book: {title: 'Programming Your Home',
                        authors: 'Mike Riley',
                        isbn: '978-1-93435-690-6'}
                     
    assert_response :redirect
    assert_redirected_to book_path(books(:steppenwolf))
    assert flash[:notice]
  end
  
  test "update book with invalid parameters" do
    put :update, id: books(:steppenwolf).id,
                 book: {title: 'Some garbage', isbn: 'invalid'}
    assert_response :success
    assert assigns(:book)
    assert assigns(:book).changed?
    assert_template :edit
  end
  
  test "delete book" do
    book = books(:steppenwolf)
    assert_difference("Book.count", -1) do
      delete :destroy, id: book.id
      assert_response :redirect
      assert_redirected_to books_path
      assert flash[:notice]
    end
  end

  test "Searching book by title" do
    get :search, query: "Rails Recipes"
    assert_response :success
    assert_template :index
    assert assigns(:books).include?(books(:rails_recipes))
  end
  
  test "Searching book by ISBN" do
    book = books(:rails_recipes)
    get :search, query: book.isbn, by: "isbn"
    assert_response :success
    assert_template :index
    assert assigns(:books).include?(book)
  end
  
  test "Searching by authors" do
    book = books(:steppenwolf)
    get :search, query: book.authors, by: "authors"
    assert_response :success
    assert_template :index
    assert assigns(:books).include?(book)
  end
end
