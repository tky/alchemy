class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def track
    items = params[:items]
    user_id = params[:user]
    type = params[:type] || 'default'

    items.split(',').each do |item|
      Track.create(item_id: item, user_id: user_id, item_type: type)
    end

    render :nothing => true, :status => 200
  end

  def recommend
    item = params[:item]
    value = Associate.where(rule_left: item).pluck(:rules_right).first
    render  json: {'recommend': value}
  end

end
