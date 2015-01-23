class CategoriesDatatable
  delegate :params, :link_to, :edit_category_path, to: :@view

  def initialize(user, view)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Category.count,
      iTotalDisplayRecords: categories.total_entries,
      aaData: data

    }
  end

private

  def data
    if @user.has_role? :admin
      categories.map do |category|
      [
        link_to(category.name, category, class: 'categoryName', title: "View " + category.name + " details", "data-placement" => "bottom"),
        link_to('', edit_category_path(category), title: "Edit", "data-placement" => "bottom", class: "glyphicon glyphicon-pencil"),
        link_to('',category, method: :delete, data: { confirm: 'Are you sure?' }, title: "Delete", "data-placement" => "bottom", remote: true, class: 'delete_category glyphicon glyphicon-trash') 
      ]
      end
    else
      categories.map do |category|
      [
        link_to(category.name, category, class: 'categoryName', title: "View " + category.name + " details", "data-placement" => "bottom") 
      ]
      end
    end
    
  end

  def categories
    @categories ||= fetch_categories
  end

  def fetch_categories
    categories = Category.order("#{sort_column} #{sort_direction}")    
    if params[:sSearch].present?
      categories = Category.where("lower(name) like :search", search: "%#{params[:sSearch].downcase}%")
    end

    categories = categories.paginate(:page => page, :per_page => per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end