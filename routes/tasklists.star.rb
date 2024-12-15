tasklists {
  before { authorize! }

  get {
    use {
      query {
        name { string }
      }
    }

    app.models.tasklists.where(name:, user_id: current_user.id)
  }

  post {
    use {
      body {
        name { required string }
      }
    }

    app.models.tasklists.create(name:, user_id: current_user.id)
  }

  scope("{tasklist_id}") {
    before {
      def id = tasklist_id

      def current_tasklist
        app.models.tasklists.find(id:) || raise(Star::Routing::NotFoundError)
      end

      def verify_tasklist_access!
        raise Star::Routing::PermissionError unless current_tasklist.user_id == current_user.id
      end
    }

    get { current_tasklist }

    patch {
      use {
        body {
          name { string }
        }
      }

      current_tasklist.update(name:)
    }

    delete { current_tasklist.delete! }

    Star.load self, "tasklists/tasks"
  }
}

tasks {
  before { authorize! }

  get {
    app.models.tasklists.where(user_id: current_user.id)
      .flat_map { |tasklist|
        app.models.tasks.where(tasklist_id: tasklist[:id])
      }
  }
}
