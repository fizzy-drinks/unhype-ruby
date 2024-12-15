tokens {
  get {
    use {
      headers {
        authorization { required string }
      }
    }

    username, password = authorization.split(":")
    user = app.models.users.find(username:)
    raise Star::Routing::AuthorizationError unless user && SCrypt::Password.new(user.password) == password

    token = app.models.tokens.create(user_id: user.id)
    token.value.to_json
  }
}
