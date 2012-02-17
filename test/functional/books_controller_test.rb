require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  test "books listing" do
    get :index
    assert_response :success
    assert assigns(:books)
  end
  
  test "show desired book" do
    existing_book = books(:steppenwolf)
    get :show, id: existing_book.id
    assert_response :success
    assert assigns(:book)
    assert_equal assigns(:book), existing_book
  end
  
  test "attempting to add new book" do
    get :new
    assert_response :success
    assert assigns(:book)
    assert assigns(:book).new_record?
  end
  
  test "creating book with valid parameters" do
    post :create, book: {title: "My title~", 
                        authors: "The Me", 
                        isbn: "978-1-93435-690-6"}
    assert_response :redirect
    assert_redirected_to books_path
    assert flash[:notice]
  end
  
  test "creating book with NOT valid parameters" do
    post :create, book: {title: "My fail title~"}
    assert_response :success
    assert assigns(:book)
    assert assigns(:book).new_record?
    assert_template :new
  end
  
  test "attempting to edit an existing book" do
    get :edit, id: books(:steppenwolf).id
    assert_response :success
    assert assigns(:book)
    assert !assigns(:book).new_record?
  end
  
  test "updating an existing book with a valid data" do
    put :update, id: books(:steppenwolf).id, book: {title: "New successful title"}
    assert_response :redirect
    assert_redirected_to book_path
    assert flash[:notice]
  end

  test "updating an existing book with NOT valid data" do
    put :update, id: books(:steppenwolf).id, book: {isbn: "My fail ISBN"}
    assert_response :success
    assert assigns(:book)
    assert assigns(:book).changed?
    assert flash[:notice]
    assert_template :edit
  end  
  
  test "deleting a book" do
    book = books(:steppenwolf)
    assert_difference("Book.count", -1) do
      delete :destroy, id: book.id
      assert_response :redirect
      assert_redirected_to books_path
      assert flash[:notice]
    end
  end
  
end
