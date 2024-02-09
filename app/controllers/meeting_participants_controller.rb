class MeetingParticipantsController < ApplicationController
  before_action :set_meeting_and_project_and_contributors, only: %i[new create]
  before_action :set_new_meeting_participant, only: %i[new create]

  def new; end

  def create
    return unless check_number_of_participants.nil?

    participants = []
    participants_params[:meeting_participant_ids].each do |participant|
      participants << @meeting.meeting_participants.build(user_role_id: participant)
    end

    return unless participants.all?(&:save)

    redirect_to project_meeting_path(@meeting.project, @meeting), notice: t('.success')
  end

  private

  def set_meeting_and_project_and_contributors
    @project = Project.find(params[:project_id])
    @meeting = Meeting.find(params[:meeting_id])
    @contributors = @project.user_roles
  end

  def set_new_meeting_participant
    @participant = MeetingParticipant.new
  end

  def check_number_of_participants
    return unless participants_params.nil? || participants_params[:meeting_participant_ids].count == 1

    flash.now[:alert] = t '.check_number_of_participants'
    render :new, status: :unprocessable_entity
  end

  def participants_params
    return unless params[:meeting_participant]

    params.require(:meeting_participant).permit(meeting_participant_ids: [])
  end
end
