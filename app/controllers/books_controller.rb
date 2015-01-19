class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index

    respond_to do |format|
      format.html
      format.json { render json: BooksDatatable.new(view_context) }
    end

  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new    
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    
  end

  # POST /books
  # POST /books.json
  def create    
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to action: :index }
        flash[:notice] = 'Book was successfully created.'
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)        
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  def destroy_multiple
    @arr_book = Array.new
    @arr_book = Book.where(:id => params[:book_ids]).pluck(:title)
    @bookCount = @arr_book.count
    @arr_book *= ', '
    
    Book.where(:id => params[:book_ids]).destroy_all

    respond_to do |format|
      format.html { redirect_to books_url }
      if @bookCount > 1
        flash[:notice] = "Books: #{@arr_book}  were successfully destroyed."
      else
        flash[:notice] = "Book: #{@arr_book}  was successfully destroyed."
      end
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :year, :category_id, :author_id, :photo)
    end
end
