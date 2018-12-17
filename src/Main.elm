module Main exposing (main)

import Browser
import GameOfLife
import GameOfLife.Pattern
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
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
    , initialUniverse : Matrix Int
    , universe : Matrix Int
    , running : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        universe =
            GameOfLife.Pattern.gosperGliderGun
    in
    ( Model 0 250 200.0 universe universe False, Cmd.none )


type Msg
    = Tick Time.Posix
    | Start
    | Pause
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            if model.step + 1 < model.maxSteps then
                ( { model | step = model.step + 1, universe = GameOfLife.transit model.universe }
                , Cmd.none
                )

            else
                ( { model | running = False }
                , Cmd.none
                )

        Start ->
            ( { model | running = True }
            , Cmd.none
            )

        Pause ->
            ( { model | running = False }
            , Cmd.none
            )

        Reset ->
            ( { model | step = 0, running = False, universe = model.initialUniverse }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.running then
        Time.every model.interval Tick

    else
        Sub.none


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Start, disabled model.running ] [ text "Start" ]
        , button [ onClick Pause, disabled (not model.running) ] [ text "Pause" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , text (" Steps " ++ String.fromInt model.step ++ "/" ++ String.fromInt model.maxSteps)
        , div [] [ viewMatrix "560" "#1f77b4" model.universe ]
        ]
