class Public::SearchController < ApplicationController
  def search
    return nil if params[:keyword] == ""
    @horons = Horon.where('name like ?', "%#{params[:keyword]}%" ).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end
end
