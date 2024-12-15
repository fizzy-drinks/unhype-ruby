model(users) {
  id { string { SecureRandom.uuid } }
  username { required string }
  password { required string }
}
