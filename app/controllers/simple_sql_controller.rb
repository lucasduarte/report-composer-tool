class SimpleSqlController < ApplicationController
  before_action :set_simple_sql, only: [:show, :edit, :update, :destroy, :execute_sql]
  before_action :set_connections, only: [:new, :edit, :update, :execute_sql]
  before_action :set_result, only: [:edit, :update, :new, :execute_sql]

   respond_to :html, :js, :json


  def index
    respond_to do |format|
      format.html
      format.json { render json: SimpleSqlDatatable.new(view_context)}
    end
  end

  def new
    @simple_sql = SimpleSql.new
  end

  def create
    @simple_sql = SimpleSql.new simple_sql_params

    if @simple_sql.save
      redirect_to edit_simple_sql_path(@simple_sql), notice: "SQL cadatrado com sucesso."
    else
      render :new, notice: "Falha ao cadastrar SQL!"
    end
  end

  def edit
  end

  def execute_sql
    begin
      @result = JSON.parse(execute_sql_remote(@simple_sql.sql, @simple_sql.connection.connection_string))
      flash[:success] = 'Comando executado com sucesso.'
    rescue => e
      flash[:error] = "Falha ao executar comando SQL: #{e.message}"
    end
  end

  def update
    if @simple_sql.update(simple_sql_params)
      redirect_to edit_simple_sql_path(@simple_sql), notice: "SQL atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @simple_sql.destroy
    redirect_to simple_sql_url, notice: 'SQL excluído com sucesso.'
  end

  private

  def simple_sql_params
    params.require(:simple_sql).permit(:connection_id, :description, :sql, :user_id)
  end

  def set_simple_sql
    @simple_sql = SimpleSql.find(params[:id])
  end

  def set_connections
    @connections = Connection.all
  end

  def execute_sql_remote(query, connection_string)
    HTTParty.post("http://127.0.0.1:5000/",
              {
                :headers => {
                  'connection_string' => connection_string,
                  'query' => query
                  }
                })
  end

  def set_result
    @result = Array.new
  end
end
