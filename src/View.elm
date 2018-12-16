module View exposing (viewMatrix)

import GameOfLife exposing (isLive)
import Html exposing (Html)
import List
import Matrix exposing (Matrix)
import Svg exposing (..)
import Svg.Attributes exposing (..)


viewMatrix : String -> String -> Matrix Int -> Html msg
viewMatrix w c matrix =
    svg
        [ width w
        , viewBox ("0 0 " ++ String.fromInt matrix.ncols ++ " " ++ String.fromInt matrix.nrows)
        ]
        [ g
            [ color c ]
            (getLiveRects matrix)
        ]


getLiveRects : Matrix Int -> List (Svg msg)
getLiveRects matrix =
    matrix
        |> Matrix.toIndexedList
        |> List.filter (\( _, value ) -> isLive value)
        |> List.map toRect


toRect : ( ( Int, Int ), Int ) -> Svg msg
toRect ( ( i, j ), _ ) =
    rect
        [ x (String.fromInt j)
        , y (String.fromInt i)
        , width "1"
        , height "1"
        , fill "currentColor"
        ]
        []
