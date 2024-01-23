class DocumentsController < ApplicationController
  before_action :set_project, only: %i[index new create]

  def index
    @documents = @project.documents
  end

  def new
    @document = @project.documents.build
  end

  def create
    @document = @project.documents.build(document_params)
    @document.save
    redirect_to project_documents_path(@project), notice: 'Documento adicionado com sucesso'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def document_params
    params.require(:document)
          .permit(:title, :description, :file)
          .merge(user: current_user)
  end
end
