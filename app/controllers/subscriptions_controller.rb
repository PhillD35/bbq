class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  before_action :your_event, only: [:create]
  before_action :ensure_uniq_email, only: [:create]


  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created', name: @event.title)
    else
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.subscriptions.destroyed', name: @subscription.event.title)}

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscriptions.error', name: @event.title)}
    end

    redirect_to @event, message
  end

  private
  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end

  def your_event
    redirect_to @event, alert: I18n.t('controllers.subscriptions.your_event_error') if current_user == @event.user
  end

  def ensure_uniq_email
    redirect_to @event, alert: I18n.t('controllers.subscriptions.email_taken_error') unless User.where(email: subscription_params[:user_email]).empty?
  end
end
