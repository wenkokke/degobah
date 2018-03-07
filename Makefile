src/static/index.js: src/elm/Main.elm
	elm-make --warn src/elm/Main.elm --output src/static/index.js
	npm run build