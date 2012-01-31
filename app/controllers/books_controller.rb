class BooksController < ApplicationController
  def index
    @books = Book.published_between(Date.today.monday, Date.today).paginate params[:page]
    respond_to do |format|
      format.html
      format.csv {
        render :text => render_csv(@books)
      }
    end
  end

  def show
    @book = Book.find params[:id]
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