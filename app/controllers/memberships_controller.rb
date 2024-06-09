class MembershipsController < ApplicationController
    before_action :set_team, only: [:create]
    before_action :set_membership, only: [:destroy]

    def create 
        @membership = @team.memberships.build(membership_params)
        if @membership.save
            redirect_to @team, notice: 'Membership was successfully created.'
        else
            redirect_to @team, alert: 'Membership was not created.'
        end
    end

    def destroy 
        @membership.destroy
        redirect_to @membership.team, notice: 'Membership was successfully destroyed.'
    end


    private

    def set_team
        @team = Team.find(params[:team_id])
    end

    def set_membership
        @membership = Membership.find(params[:id])
    end

    def membership_params
        params.require(:membership).permit(:user_id)
    end
end
