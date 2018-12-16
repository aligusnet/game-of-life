module GameOfLife exposing (batchInitialize, initialize, isLive, transit)

import List
import Matrix exposing (Matrix)
import Maybe


{-| Initialize a universe using the given pattern.
-}
initialize : ( Int, Int ) -> Matrix Int -> Matrix Int
initialize ( minNrows, minNcols ) pattern =
    let
        nrows =
            max minNrows pattern.nrows

        ncols =
            max minNcols pattern.ncols

        offsetI =
            (nrows - pattern.nrows) // 2

        offsetJ =
            (ncols - pattern.ncols) // 2

        f ( i, j ) =
            Maybe.withDefault 0 (Matrix.get ( i - offsetI, j - offsetJ ) pattern)
    in
    Matrix.initialize ( nrows, ncols ) f


{-| Initialize a universe using the given lis of patterns with offsets.
-}
batchInitialize : ( Int, Int ) -> List ( ( Int, Int ), Matrix Int ) -> Matrix Int
batchInitialize ( nrows, ncols ) patterns =
    let
        f ( i, j ) =
            patterns
                |> List.filterMap (\( ( offsetI, offsetJ ), pattern ) -> Matrix.get ( i - offsetI, j - offsetJ ) pattern)
                |> List.maximum
                |> Maybe.withDefault 0
    in
    Matrix.initialize ( nrows, ncols ) f


{-| Calculates the next state of the universe.
-}
transit : Matrix Int -> Matrix Int
transit grid =
    Matrix.indexedMap (transitCell grid) grid


{-| Calculates the next state of the cell.
-}
transitCell : Matrix Int -> ( Int, Int ) -> Int -> Int
transitCell grid cell value =
    case getNumberOfLiveNeighbors grid cell of
        2 ->
            if isLive value then
                1

            else
                0

        3 ->
            1

        _ ->
            0


{-| Return nubver of live neighbors.
-}
getNumberOfLiveNeighbors : Matrix Int -> ( Int, Int ) -> Int
getNumberOfLiveNeighbors grid ( i, j ) =
    let
        get idx =
            Matrix.get idx grid
                |> Maybe.map
                    (\v ->
                        if isLive v then
                            1

                        else
                            0
                    )

        neighborIndices =
            [ ( i - 1, j - 1 )
            , ( i - 1, j )
            , ( i - 1, j + 1 )
            , ( i, j - 1 )
            , ( i, j + 1 )
            , ( i + 1, j - 1 )
            , ( i + 1, j )
            , ( i + 1, j + 1 )
            ]
    in
    List.filterMap get neighborIndices
        |> List.sum


{-| Return true the cell's value indicates it is alive.
-}
isLive : Int -> Bool
isLive value =
    value > 0
