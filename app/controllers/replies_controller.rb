class RepliesController < ApplicationController
  def new
    @reply = Reply.find(params[:id])
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.post_id = params[:post_id]
    @reply.user = current_user

    if @reply.save
      redirect_to request.referrer, alert: @reply.errors.full_message.join('. ').to_s
    end
  end

  def destroy
    @reply = Reply.find(params[:id])

    @reply.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Reply was successfully destroyed.' }
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
