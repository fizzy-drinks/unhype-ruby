model(tokens) {
  value { string { Base64.encode64(SecureRandom.uuid).strip } }
  user_id { required string }
  issued { date { DateTime.now } }
}
