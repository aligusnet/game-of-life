module Main exposing (main)

import Browser
import GameOfLife
import GameOfLife.Pattern
import Html exposing (..)
import Matrix exposing (Matrix)
import Time
import View exposing (viewMatrix)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { step : Int
    , maxSteps : Int
    , interval : Float
    , universe : Matrix Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 0 100 200 GameOfLife.Pattern.engine, Cmd.none )


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | step = model.step + 1, universe = GameOfLife.transit model.universe }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.step < 100 then
        Time.every model.interval Tick

    else
        Sub.none


view : Model -> Html Msg
view model =
    div [] [ viewMatrix model.universe ]
