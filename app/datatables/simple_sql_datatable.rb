class SimpleSqlDatatable
  delegate :params, :content_tag, :edit_simple_sql_path, :destroy_simple_sql_path, :simple_sql_index_path, :link_to, :button_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: SimpleSql.count,
      iTotalDisplayRecords: simple_sqls.total_count,
      aaData: data
    }
  end

  private
    def data
      simple_sqls.map do |simple_sql|
        [
          simple_sql.description,
          simple_sql.connection.name,
          link_to(simple_sql, class: 'btn btn-info') do
            content_tag(:span, '', :class => "glyphicon glyphicon-info-sign")
          end,
          link_to(edit_simple_sql_path(simple_sql), class: 'btn btn-default') do
            content_tag(:span, '', :class => "glyphicon glyphicon-edit")
          end,
          content_tag(:button, class: 'btn btn-danger', 'data-toggle' => 'modal', 'data-target' => '#app_modal', 'data-simple_sql-id' => simple_sql.id) do
            content_tag(:span, '', :class => "glyphicon glyphicon-trash") 
          end
        ]
      end
    end

    def simple_sqls
      @simple_sqls ||= fetch_simple_sqls
    end

    def fetch_simple_sqls
      simple_sqls = SimpleSql.order("#{sort_column} #{sort_direction}")
      simple_sqls = simple_sqls.page(page).per(per)
      if params[:sSearch].present?
        simple_sqls = simple_sqls.where("description ilike :search", search: "%#{params[:sSearch]}%")
      end
      simple_sqls
    end

    def page
      params[:iDisplayStart].to_i/per + 1
    end

    def per
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[description]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end