class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def new
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
     @user = current_user
     @books = Book.all
     render :index
   end
  end


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user # この行を追加
  end

  def edit
    @book = Book.find(params[:id])
    if current_user == @book.user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
