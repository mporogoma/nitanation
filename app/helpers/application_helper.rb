module ApplicationHelper
  include Pagy::Frontend

  def flash_class(type)
    case type.to_sym
    when :notice then "flash-notice"
    when :alert  then "flash-alert"
    when :error  then "flash-alert"
    when :warning then "flash-warning"
    else "flash-#{type}"
    end
  end
end
