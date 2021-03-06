class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :login, type: String
  field :gid, type: String
  field :avatar_url, type: String
  field :url, type: String

  field :last_activity_at, type: Time
  field :points, type: Integer, default: 0
  field :level, type: Integer, default: 0
  field :achievements, type: Array, default: []

  validates_uniqueness_of :login

  after_create :track_stats

  def self.find_or_create_by_login(login)
    User.where(login: login).first || User.create(login: login)
  end

  def self.find_or_build_from_json(json_data)
    return if json_data.blank?

    user = User.where(gid: json_data["id"]).first
    unless user
      user = User.new
    end

    user.login = json_data["login"]
    user.gid = json_data["id"]
    user.avatar_url = json_data["avatar_url"]
    user.url = json_data["html_url"]

    user.save
    user
  end

  private
  def track_stats
    Stats.increment(self.created_at, :collaborators, 1)
  end
end

