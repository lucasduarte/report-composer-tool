class SimpleSqlController < ApplicationController
  before_action :set_simple_sql, only: [:show, :edit, :update, :destroy]

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
      redirect_to @simple_sql, notice: "SQL cadatrado com sucesso."
    else
      render :new, notice: "Falha ao cadastrar SQL!"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @simple_sql.update(connection_params)
      redirect_to @simple_sql, notice: "SQL atualizado com sucesso."
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
end
