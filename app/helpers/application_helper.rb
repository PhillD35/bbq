module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: 'success',
      error: 'danger',
      alert: 'danger',
      notice: 'success'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def bootstrap_flash(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert alert-#{bootstrap_class_for(msg_type)}", role: 'alert') do
        concat content_tag(:button, bi_icon('x-octagon-fill'),
          class: "close text-#{bootstrap_class_for(msg_type)}", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def bi_icon(icon_class)
    content_tag(:span, '', class: "ml-1 bi bi-#{icon_class}")
  end

  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end
end
