Gamegit::App.controllers :events do
  get :index, :map => '/events' do
    time = Time.zone.at([params[:timestamp].to_i, 0].max)
    events = Event.desc(:created_at).where(:created_at.gt => time).limit(20)

    angular_response 200, events
  end
end
