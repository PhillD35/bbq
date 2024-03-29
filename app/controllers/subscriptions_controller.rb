class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_subscription, only: :destroy

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if current_user == @event.user
      redirect_to @event, alert: I18n.t('controllers.general.not_allowed')
    elsif @new_subscription.save
      redirect_to @event, notice: I18n.t('controllers.subscriptions.create')
    else
      render 'events/show', alert: I18n.t('controllers.general.error')
    end
  end

  def destroy
    if current_user_can_edit?(@subscription)
      @subscription.destroy
      redirect_to @event, notice: I18n.t('controllers.subscriptions.destroy')
    else
      redirect_to @event, alert: I18n.t('controllers.general.not_allowed')
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
