module Main exposing (main)

import Browser
import Html exposing (..)
import Time


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
    , interval : Float
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 0 200, Cmd.none )


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | step = model.step + 1 }
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
    div [] [ text (String.fromInt model.step) ]
