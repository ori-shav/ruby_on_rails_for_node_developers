class MembersController < ApplicationController

    def index
        members = Member.all.limit(32)
        render :json => members
    end

    def create
        member = Member.new(member_params)

        if member.save
            render :ok
        else
            throw "invalid data"    
        end
    end

    def show
        member = Member.find(params[:id])
        render :json => member
    end

    def update
        member = Member.find(params[:id])

        if member.update(member_params)
            render :ok
        else
            throw "invalid data"
        end
    end

    def destroy
        Member.destroy(params[:id])
        render :ok
    end

    private
        def member_params
            params.require(:member).permit(:email, :subscribed)
        end

end
