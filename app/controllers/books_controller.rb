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

  def destroy 
    book = Book.find(params[:id]).destroy!
    # We use the objects 'ID' as reference to delete (eg book id 2)
    # curl --header "Content-Type: application/json" --request DELETE  http://localhost:3000/books/2 -v

    # BELOW, there is no need to render a json object as the object has been deleted, thus render a 'head' with a 'no_content' ststus code
    head :no_content
    # If the destroy action fails for some reason, we can write a rescue block below.
    # There are some disadvantages to having a rescue block in the controller action, as adding a few of them will make the conrroller bloated, best way to do this: 
    # In the ApplicationController Create a private method eg 'not_destroyed, and add rescue_from... to the top (ref ApplicationController)
  # rescue ActiveRecord::RecordNotDestroyed
  #   render json: {}, status: :unprocessable_entity
   
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end

end
