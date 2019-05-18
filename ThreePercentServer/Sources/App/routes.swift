import Vapor

struct CreateUserResponse: Content {
    var id: String
    var upload_url: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("ping") { req in
        return "pong"
    }

    router.post("user") { req -> CreateUserResponse in
        var id = UUID().uuidString
        return CreateUserResponse(
            id: id,
            upload_url: "https://example.com/abc"
        )
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
