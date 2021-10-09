class BooksController < ApplicationController

  def index
    #To Test this: curl http://localhost:3000/books
    render json: Book.all
  end

  def create 
    #To Test this: curl --request POST http://localhost:3000/books
    book = Book.new(book_params)

    if book.save 
      render json: book, status: :created # Status 201 means created
    else
      render json: book.errors, status: :unprocessable_entity # Status 422 means unprocessable entity
    end
    # Example using book_params: 
    # curl --header "Content-Type: application/json" --request POST --data '{"author": "Trevor Noah", "title": "Born a Crime"}' http://localhost:3000/books -v
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
