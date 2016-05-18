module ApplicationHelper
  # returns the gravatar image for a given user. You can also specify the size.
  # Example: gravatar_for(@user, size: 190)
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    image_tag "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}", alt: user.username, class: "img-circle"
  end

  # returns the kind of alert needed based on the flash message type
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
