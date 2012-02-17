class ReservationsController < ApplicationController
  before_filter :find_book, only: [:new, :create, :free]

  def new
    @reservation = @book.reservations.new
  end
  
  def create
    @reservation = @book.reservations.new(params[:reservation])
    if @reservation.save
      flash[:notice] = "Reservation success!"
      redirect_to book_path(@book)
    else
      flash[:notice] = "Book has already been reserved!"
      render action: :new
    end
  end
  
  def free
    @reservation = @book.reservations.find(params[:id])
    if @reservation.free
      flash[:notice] = "Book is no longer reserved"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to book_path(@book)
  end
  
  private
  
  def find_book
    @book = Book.find(params[:book_id])
  end
end
