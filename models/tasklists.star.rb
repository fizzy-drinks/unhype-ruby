model(tasklists) {
  id { string { SecureRandom.uuid } }
  name { required string }
  user_id { required string }
}
