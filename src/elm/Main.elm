module Main exposing (..)

import Dict
import Html exposing (Html, a, div, h1, hr, small)
import String
import Svg exposing (Svg, g, polygon, text, text_)
import Svg.Attributes as Sattr exposing (fill, points, stroke, x, y)
import Svg.Events as Sevent exposing (onClick, onMouseOver)
import HexGrid exposing (Direction(..), HexGrid(..))

type alias Model =
    { grid        : HexGrid ()
    , activePoint : HexGrid.Point
    , hoverPoint  : Maybe HexGrid.Point
    }

type Msg
    = NoOp
    | ActivePoint HexGrid.Point
    | HoverPoint  HexGrid.Point

init : Model
init = { grid        = HexGrid.empty 5 ()
       , activePoint = (0, 0)
       , hoverPoint  = Nothing
       }

update : Msg -> Model -> Model
update msg model =
    case msg of
         NoOp              -> model
         ActivePoint point -> { model | activePoint = point }
         HoverPoint  point -> { model | hoverPoint  = Just point }

view : Model -> Svg Msg
view model =
    let
        (HexGrid _ dict) =
            model.grid

        cornersToStr corners =
            corners
                |> List.map (\( x, y ) -> toString x ++ "," ++ toString y)
                |> String.join " "

        -- not flipped this time
        layout =
            HexGrid.mkPointyTop 30 30 (600 / 2) (570 / 2)

        renderPoint ( point, tile ) =
            let
                ( centerX, centerY ) =
                    HexGrid.hexToPixel layout point

                corners =
                    HexGrid.polygonCorners layout point
            in
                g
                    [ onClick (ActivePoint point)
                    , onMouseOver (HoverPoint point)
                    ]
                    [ polygon
                        [ points (cornersToStr <| corners)
                        , stroke "black"
                        , fill <|
                            if model.activePoint == point then
                                "grey"
                            else if model.hoverPoint == Just point then
                                "#f1c40f"
                                -- gold
                            else
                                "white"
                        ]
                        []
                    ]
    in
        Svg.svg
            []
            (List.map renderPoint (Dict.toList dict))

main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
