import Widget from require "lapis.html"
import escape from require "lapis.util"

class extends Widget
    content: =>
        p "In a URL: "
        p, ->
            a href: escape(@value.value), "Click *me* if you dare."