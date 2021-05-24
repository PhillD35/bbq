class CommentsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_comment, only: :destroy

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      redirect_to @event, notice: I18n.t('controllers.comments.create')
    else
      render 'events/show', alert: I18n.t('controllers.common.error')
    end
  end

  def destroy
    if current_user_can_edit?(@comment)
      @comment.destroy

      redirect_to @event, notice: I18n.t('controllers.comments.destroy')
    else
      redirect_to @event, alert: I18n.t('controllers.common.not_allowed')
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
