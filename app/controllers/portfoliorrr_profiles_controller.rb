class PortfoliorrrProfilesController < ApplicationController
  before_action :set_project, only: %i[search show]

  before_action :leader?, only: %i[search show]

  def show
    @portfoliorrr_profile_id = params[:id].to_i
    @current_invitation = @project.invitations.find_by(profile_id: @portfoliorrr_profile_id,
                                                       status: %i[pending processing])
    @current_invitation&.validate_expiration_days
    @portfoliorrr_profile = PortfoliorrrProfile.find(@portfoliorrr_profile_id)

    unless @current_invitation&.pending? || @current_invitation&.processing?
      @current_proposal = Proposal.find_by(project: @project, profile_id: @portfoliorrr_profile_id, status: :pending)
    end

    @invitation = Invitation.new
  end

  def search
    @query = params[:q]
    @portfoliorrr_profiles = @query ? PortfoliorrrProfile.search(@query) : PortfoliorrrProfile.all
  end

  private

  def leader?
    redirect_to root_path, alert: t('unauthorized') unless @project.leader?(current_user)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
