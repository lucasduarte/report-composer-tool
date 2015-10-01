class ConnectionsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Connection.count,
      iTotalDisplayRecords: connections.total_count,
      aaData: data
    }
  end

  private
    def data
      connections.map do |connection|
        [
          link_to(connection.name, connection),
          connection.provider,
          connection.connection_string,
          connection.timeout
        ]
      end
    end

    def connections
      @connections ||= fetch_connections
    end

    def fetch_connections
      connections = Connection.order("#{sort_column} #{sort_direction}")
      connections = connections.page(page).per(per)
      if params[:sSearch].present?
        connections = connections.where("name ilike :search or provider ilike :search or connection_string ilike :search", search: "%#{params[:sSearch]}%")
      end
      connections
    end

    def page
      params[:iDisplayStart].to_i/per + 1
    end

    def per
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[name provider]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
  end