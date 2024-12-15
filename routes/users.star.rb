users {
  post {
    use {
      body {
        username { required string }
        password { required string }
      }
    }

    already_exists = app.models.users.find(username:)
    next {message: "This username is taken!"} if already_exists

    hashed = SCrypt::Password.create(password)
    app.models.users.create(username:, password: hashed)

    {username:}
  }

  get("me") {
    authorize!
    current_user => {username:, id:}
    {username:, id:}
  }
}
