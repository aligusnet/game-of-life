module SpeedInterval exposing (SpeedInterval, default, defaultIndex, get, size)

{-| Represents list of possible values
of correspondent values of universes' update intervals and speeds.
-}

import Array exposing (Array)


type alias SpeedInterval =
    { speed : String
    , interval : Float
    }


create : Int -> SpeedInterval
create speed =
    SpeedInterval (String.fromInt speed) (1000.0 / toFloat speed)


default : SpeedInterval
default =
    create 10


defaultIndex : Int
defaultIndex =
    3


get : String -> SpeedInterval
get index =
    let
        i =
            Maybe.withDefault defaultIndex (String.toInt index)
    in
    Maybe.withDefault default (Array.get i values)


values : Array SpeedInterval
values =
    [ 1, 2, 5, 10, 24, 40, 100 ]
        |> List.map create
        |> Array.fromList


size : Int
size =
    Array.length values
