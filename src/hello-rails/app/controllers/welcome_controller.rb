class WelcomeController < ApplicationController
  def index
    @ip = request.remote_ip
    visitor = Visitor.find_by(:ip => @ip)
    if visitor != nil
      visitor.visits =visitor.visits + 1
      visitor.save
    else
      visitor = Visitor.new
      visitor.ip = @ip
      visitor.visits = 1
      visitor.save
    end

    @visitors = Visitor.all
  end
end
