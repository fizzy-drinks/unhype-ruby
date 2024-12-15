before {
  puts "#{request.method} #{request.uri}"

  def now = DateTime.now

  def authorize!
    use {
      headers {
        authorization { string }
      }
    }

    token = app.models.tokens.find(value: authorization)
    raise Star::Routing::AuthorizationError unless token

    @user = app.models.users.find(id: token.user_id)
    raise Star::Routing::AuthorizationError unless current_user
  end

  def current_user = @user
}
