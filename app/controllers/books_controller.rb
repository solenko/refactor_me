class BooksController < ApplicationController
  respond_to :html, :text
  def index
    @books = Book.where(:draft => false).published_between(Date.today.monday, Date.today).paginate params[:page]
    respond_to do |format|
      format.html
      format.csv {
        render :text => render_csv(@books)
      }
    end
  end

  def my
    @books = Book.where(:user_id => current_user.id).paginate params[:page]
    render 'index'
  end

  def show
    @book = Book.find params[:id]
    respond_with(@book)
  end

  def create
    @book = Book.new(params[:book])
    @book.save
    respond_with(@book)
  end

  def edit
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find params[:id]
    @book.update_attributes(params[:book])
    respond_with(@book)
  end

  private
    def render_csv(books)
      content = ''
      books.each do |book|
        content += render_csv_book(book)
      end
      content
    end

    def render_csv_book(book)
      content = render_csv_field(book.isbn)
      content += ','
      content += render_csv_field(book.title)
      content += ','
      content += render_csv_field(book.author.name)
      content += ','
      content += render_csv_field(book.category.name)
      content += "\n"
      content
    end

    def render_csv_field(field)
      case field
        when /,/ then render_quoted(field)
        when /"/ then render_quoted(field)
        else field
      end
    end

    def render_quoted(field)
      content =  "\""
      content += field.gsub(/\"/, "\"\"")
      content += "\""
      content
    end
end