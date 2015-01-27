class BooksDatatable
  delegate :params, :check_box_tag, :link_to, to: :@view

  def initialize(user, view)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Book.count,
      iTotalDisplayRecords: books.total_entries,
      aaData: data
    }
  end

private

  def data
    if @user.has_role? :admin
      books.map do |book|
      [
        book.author.name,
        link_to(book.title, book, class: "bookName", title: "View " + book.title + " details", "data-placement" => "bottom"),
        book.year.to_i,
        link_to(book.category.name, '#', class: "bookCategory"),
        check_box_tag('book_ids[]', book.id, false, class: 'chxBook'),
        link_to('',book, method: :delete, data: { confirm: 'Are you sure?' }, title: "Delete", "data-placement" => "bottom", remote: true, class: 'delete_book glyphicon glyphicon-trash') 
      ]
      end
    else
      books.map do |book|
      [
        book.author.name,
        link_to(book.title, book, class: "bookName", title: "View " + book.title + " details", "data-placement" => "bottom"),
        book.year.to_i,
        link_to(book.category.name, '#', class: "bookCategory"),
        "",
        ""
      ]
    end
    end
    
  end

  def books
    @books ||= fetch_books
  end

  def columns
    ['author', 'title', 'year', 'category']
  end

  def fetch_books
    books = Book.order("#{sort_column} #{sort_direction}")

    if params[:sSearch].present?
      books = Book.joins(:author).where("lower(title) like :search or lower(authors.name) like :search ", search: "%#{params[:sSearch].downcase}%")
    end

    if params[:sSearch_3].present?
      books = Book.joins(:category).where("lower(categories.name) like :sSearch_3", sSearch_3: "%#{params[:sSearch_3].downcase}%")
    end

    if (params[:sSearch].present? && params[:sSearch_3].present?)
      books = Book.joins(:author).joins(:category).where("(lower(title) like :search or lower(authors.name) like :search) and (lower(categories.name) like :sSearch_3)", search: "%#{params[:sSearch].downcase}%", sSearch_3: "%#{params[:sSearch_3].downcase}%")
    end


    books = books.paginate(:page => page, :per_page => per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[author_id title year]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end