model(tasks) {
  id { string { SecureRandom.uuid } }
  title { required string }
  description { string { "" } }
  tasklist_id { required string }
  created_at { date { DateTime.now } }
  modified_at { date { DateTime.now } }
  date_due { date { DateTime.now } }
  closed_at { date }
  deleted_at { date }
}
