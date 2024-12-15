tasks {
  get { app.models.tasks.where(tasklist_id:) }

  post {
    use {
      body {
        title { required string }
        date_due { date { DateTime.now } }
      }
    }

    app.models.tasks.create(tasklist_id:, title:, date_due:)
  }

  scope("{task_id}") {
    before {
      def id = task_id

      def current_task = app.models.tasks.find(tasklist_id:, id:)
    }

    get { current_task }

    patch {
      use {
        body {
          title { string }
          description { string }
          date_due { date }
          closed_at { date }
        }
      }

      update = {title:, date_due:, closed_at:, description:, modified_at: now}
        .filter { |k, v| !v.nil? }
        .to_h

      current_task.update(update)
    }

    delete { current_task.update(deleted_at: now) }
  }
}
