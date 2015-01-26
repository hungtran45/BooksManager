class AuthorsDatatable
  delegate :params, :link_to, :edit_author_path, to: :@view

  def initialize(user, view)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Author.count,
      iTotalDisplayRecords: authors.total_entries,
      aaData: data

    }
  end

private

  def data
    if @user.has_role? :admin
      authors.map do |author|
      [
        link_to(author.name, author, class: 'authorName', title: "View " + author.name + " details", "data-placement" => "bottom"),
        author.email,
        link_to('', edit_author_path(author), title: "Edit", "data-placement" => "bottom", class: "glyphicon glyphicon-pencil"),
        link_to('',author, method: :delete, data: { confirm: 'Are you sure?' }, title: "Delete", "data-placement" => "bottom", remote: true, class: 'delete_author glyphicon glyphicon-trash') 
      ]
      end
    else
      authors.map do |author|
      [
        link_to(author.name, author, class: 'authorName', title: "View " + author.name + " details", "data-placement" => "bottom"),
        author.email,
        "",
        ""
      ]
      end
    end
    
  end

  def authors
    @authors ||= fetch_authors
  end

  def fetch_authors
    authors = Author.order("#{sort_column} #{sort_direction}")    
    if params[:sSearch].present?
      authors = Author.where("lower(name) like :search or lower(email) like :search", search: "%#{params[:sSearch].downcase}%")
    end

    authors = authors.paginate(:page => page, :per_page => per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name email]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end