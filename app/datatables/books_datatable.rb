class BooksDatatable
  delegate :params, :check_box_tag, :link_to, to: :@view

  def initialize(view)
    @view = view
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
    books.map do |book|
      [
        book.author.name,
        link_to(book.title, book, class: "bookName", title: "View " + book.title + " details", "data-placement" => "bottom"),
        book.year.to_i,
        book.category.name,
        check_box_tag('book_ids[]', book.id, false, class: 'chxBook'),
        link_to('',book, method: :delete, data: { confirm: 'Are you sure?' }, title: "Delete", "data-placement" => "bottom", remote: true, class: 'delete_book glyphicon glyphicon-trash') 
      ]
    end
  end

  def books
    @books ||= fetch_books
  end

  def fetch_books
    books = Book.order("#{sort_column} #{sort_direction}")    
    if params[:sSearch].present?
      books = Book.joins(:author).where("lower(title) like :search or lower(authors.name) like :search ", search: "%#{params[:sSearch].downcase}%")
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