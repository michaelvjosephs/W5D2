require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    cookie = req.cookies["_rails_lite_app"]

    if cookie.nil?
      @session = {}
    else
      @session = JSON.parse(cookie)
    end

  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie = @session.to_json
    res.set_cookie("_rails_lite_app", { path: "/", value: cookie })
  end
end
