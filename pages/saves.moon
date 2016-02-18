lapis = require "lapis"

Saves = require "models.Saves"

class SavesApp extends lapis.Application
    "/save": => redirect_to: @url_for("saves"), status: 301

    [saves: "/saves"]: =>
        @saves = Saves\select!
        render: true

    [save: "/save/:id"]: => --TODO rewrite this as well! more details please!
        @html ->
            if save = Saves\find @params.id
                h1 "It's working, shut up"
                p @params.id
                a href: @build_url(save.file), "Test"
            else
                @write status: 404, "Not found"
