module ApplicationHelper
  # def bootstrap_class_for flash_type
  #   { success: "alert-success", danger: "alert-danger", warning: "alert-warning", info: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  # end

  # def flash_messages(opts = {})
  #   flash.each do |msg_type, message|
  #     concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade in", role: 'alert') do
  #       concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
  #         concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
  #         concat content_tag(:span, 'Close', class: 'sr-only')
  #       end)
  #       concat message
  #     end)
  #   end
  #   nil
  # end

  def bootstrap_class_for flash_type
    # binding.pry
    case flash_type
    when "success"
      "alert-success"
    when "info"
      "alert-info"
    when "warning"
      "alert-warning"
    when "danger"
      "alert-danger"
    end
  end
end
