class ImportsController < ApplicationController

  # # GET /import/new
  def new
    @importer = Importer.new
  end

  # POST /import
  def create
    @importer = Importer.new

    tab_file_path = params[:tab_file].respond_to?(:path) ? params[:tab_file].path : nil

    if @importer.import(tab_file_path)
      flash[:gross_revenue] = @importer.gross_revenue
      redirect_to new_import_path,
        notice: t('import.success'),
        status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

end
