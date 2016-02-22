import Widget from require "lapis.html"

Users = require "models.Users"

class Layout extends Widget
    content: =>
        html_5 ->
            head ->
                meta charset: "utf-8"
                meta name: "viewport", content: "width=device-width, initial-scale=1.0"
                title @title or "K.S.S."
                link rel: "stylesheet", href: @build_url "static/css/pure-min.css"
                link rel: "stylesheet", href: @build_url "static/css/side-menu.css"
                link rel: "stylesheet", href: @build_url "static/css/custom.css"
            body ->
                div id: "layout", ->
                    a href: "#menu", id: "menuLink", class: "menu-link", ->
                        span! -- Hamburger icon!
                    div id: "menu", ->
                        div class: "pure-menu", ->
                            a class: "pure-menu-heading", href: @url_for("index"), "K.S.S." --NOTE top level special looking link (should it be used??)
                            ul class: "pure-menu-list", ->
                                li class: "pure-menu-item", -> a href: @url_for("saves"), class: "pure-menu-link", "Saves"
                                li class: "pure-menu-item", -> a href: @url_for("users"), class: "pure-menu-link", "Users"
                            hr!
                            day = os.date("!*t").wday
                            user = Users\find weekday: day
                            if user
                                p "Current user:", br, user.name
                            else
                                p "Current user:", br, "N/A"
                            p "Time remaining:", br, "TIME" --TODO end of today - current time
                            tomorrow = day + 1
                            if tomorrow == 8
                                tomorrow = 1
                            user = Users\find weekday: tomorrow
                            if user
                                p "Next user:", br, user.name
                            else
                                p "Next user:", br, "N/A"
                            hr!
                            ul class: "pure-menu-list", ->
                                if @session.username
                                    li class: "pure-menu-item", -> a href: @url_for("logout"), class: "pure-menu-link", "Log Out"
                                    user = Users\find name: @session.username
                                    if (user.weekday == day) or user.admin
                                        li class: "pure-menu-item", -> a href: @url_for("upload"), class: "pure-menu-link", "Upload"
                                else
                                    li class: "pure-menu-item", -> a href: @url_for("login"), class: "pure-menu-link", "Log In"
                                    li class: "pure-menu-item", -> a href: @url_for("create_user"), class: "pure-menu-link", "Create Account"
                            hr!
                            p "Date:", br, os.date("!%Y/%m/%d") , br, "Time:", br , os.date("!%H:%M")
                    div id: "main", ->
                        div class: "header", ->
                            h1 @title or "Kerbal Save Sharing"
                            h2 @subtitle if @subtitle
                        div class: "content", ->
                            @content_for "inner"
                    div id: "footer", ->
                        hr!
                        a href: "https://github.com/Guard13007/KSS", target="_blank", "Source"
                        text " | "
                        a href: "https://github.com/Guard13007/KSS/issues", target="_blank", "Issues"
                script src: @build_url "static/js/ui.js"
