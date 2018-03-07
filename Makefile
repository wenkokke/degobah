all: static/main.html

static/main.html: src/elm/Main.elm
	elm-make --warn src/elm/Main.elm --output static/main.html