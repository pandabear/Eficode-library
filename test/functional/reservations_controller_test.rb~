require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  setup do
    @book = books(:steppenwolf)
    @reserved_book = books(:rails_recipes)
    @reservation = @reserved_book.reservations.create(email: "h@douken.com")
  end

  test "attempting to reserve a book" do
    get :new, book_id: @book.id
    assert_response :success
    assert_equal @book, assigns(:reservation).book
    assert assigns(:reservation)
    assert assigns(:reservation).new_record?
  end
  
  test "reserving a book successfully" do
    post :create, book_id: @book.id, reservation: {email: "h@douken.com" }
    assert_response :redirect
    assert_redirected_to book_path(@book.id)
    assert flash[:notice]
  end
  
  test "reserving a book with fail" do
    post :create, book_id: @book.id, reservation: {email: "f@i.l" }
    assert_response :success
    assert_template :new
    assert assigns(:reservation)
    assert assigns(:reservation).invalid?
    assert assigns(:reservation).new_record?
    assert flash[:notice]
  end
  
  test "free reservation" do
    put :free, book_id: @reserved_book.id, id: @reservation.id
    assert_response :redirect
    assert_redirected_to book_path(@reserved_book)
    assert_equal "free", assigns(:reservation).state
    assert flash[:notice]
  end
end
