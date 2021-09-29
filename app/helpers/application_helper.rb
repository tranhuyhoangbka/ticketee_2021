module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << 'Ticketee').join(' - ')
      end
    end
  end

  def admins_only(&block)
    block.call if current_user&.admin?
  end
end
