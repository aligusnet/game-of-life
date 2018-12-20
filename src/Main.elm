module Main exposing (main)

import Browser
import Dict exposing (Dict)
import GameOfLife
import GameOfLife.Pattern
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, targetValue)
import Json.Decode as Json
import Matrix exposing (Matrix)
import SpeedInterval as SI
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
    , si : SI.SpeedInterval
    , initialUniverse : Matrix Int
    , universe : Matrix Int
    , running : Bool
    }


defaultMaxSteps : Int
defaultMaxSteps =
    500


init : () -> ( Model, Cmd Msg )
init _ =
    let
        universe =
            defaultUniverse
    in
    ( Model 0 defaultMaxSteps SI.default universe universe False, Cmd.none )


type Msg
    = Tick Time.Posix
    | Start
    | Pause
    | Reset
    | SetUniverse String
    | SetInterval String
    | SetMaxSteps String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            if model.step + 1 <= model.maxSteps then
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

        SetUniverse key ->
            ( resetUniverse key model
            , Cmd.none
            )

        SetInterval index ->
            ( { model | si = SI.get index }
            , Cmd.none
            )

        SetMaxSteps value ->
            ( { model | maxSteps = String.toInt value |> Maybe.withDefault defaultMaxSteps }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.running then
        Time.every model.si.interval Tick

    else
        Sub.none


view : Model -> Html Msg
view model =
    let
        isUniverseSelected =
            model.initialUniverse /= defaultUniverse
    in
    div []
        ([ viewUniverseSelect
         , viewSpeedPanel model
         , viewMaxStepsPanel model
         , viewControlPanel model
         ]
            ++ [ div [ class "universe", hidden (not isUniverseSelected) ] [ viewMatrix model.universe ] ]
        )


viewControlPanel : Model -> Html Msg
viewControlPanel model =
    div [ class "control-panel" ]
        [ button [ onClick Start, disabled model.running ] [ text "Start" ]
        , button [ onClick Pause, disabled (not model.running) ] [ text "Pause" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , text (" Steps " ++ String.fromInt model.step ++ "/" ++ String.fromInt model.maxSteps)
        ]


viewPanel caption inputName inputProperties txt =
    div [ class "panel" ]
        [ div [ class "panel-label" ] [ label [ for inputName ] [ text caption ] ]
        , input ([ name inputName, class "panel-input" ] ++ inputProperties) []
        , div [ class "panel-value" ] [ text txt ]
        ]


viewSpeedPanel : Model -> Html Msg
viewSpeedPanel model =
    let
        valueProp =
            if not model.running && model.si == SI.default then
                [ value (String.fromInt SI.defaultIndex) ]

            else
                []

        properties =
            valueProp
                ++ [ type_ "range"
                   , Html.Attributes.min "0"
                   , step "1"
                   , Html.Attributes.max (String.fromInt (SI.size - 1))
                   , on "change" (Json.map SetInterval targetValue)
                   ]
    in
    viewPanel "Speed" "speed" properties (model.si.speed ++ " ticks/sec.")


viewMaxStepsPanel : Model -> Html Msg
viewMaxStepsPanel model =
    let
        maxSteps =
            String.fromInt model.maxSteps

        valueProp =
            if not model.running && model.maxSteps == defaultMaxSteps then
                [ value maxSteps ]

            else
                []

        properties =
            valueProp
                ++ [ type_ "range"
                   , Html.Attributes.min "0"
                   , step "50"
                   , Html.Attributes.max "1000"
                   , on "change" (Json.map SetMaxSteps targetValue)
                   ]
    in
    viewPanel "Max Steps" "steps" properties maxSteps


viewUniverseSelect : Html Msg
viewUniverseSelect =
    let
        options =
            universeList
                |> List.map (\( v, t, _ ) -> option [ value v ] [ text t ])
    in
    select [ class "universe-select", on "change" (Json.map SetUniverse targetValue) ] options


getUniverse : String -> Matrix Int
getUniverse key =
    Dict.get key universeDict
        |> Maybe.withDefault defaultUniverse


defaultUniverse : Matrix Int
defaultUniverse =
    Matrix.fromList [] 1


universeList : List ( String, String, Matrix Int )
universeList =
    [ ( "default", "Select Universe", defaultUniverse )
    , ( "universe1", "Engine, boat and blinkers", GameOfLife.Pattern.universe1 )
    , ( "universe2", "Pulsar and blinkers", GameOfLife.Pattern.universe2 )
    , ( "gosperGliderGun", "Gosper glider gun", GameOfLife.Pattern.gosperGliderGun )
    ]


universeDict : Dict String (Matrix Int)
universeDict =
    universeList
        |> List.map (\( k, _, v ) -> ( k, v ))
        |> Dict.fromList


resetUniverse : String -> Model -> Model
resetUniverse key model =
    let
        universe =
            getUniverse key
    in
    { model | step = 0, running = False, initialUniverse = universe, universe = universe }
