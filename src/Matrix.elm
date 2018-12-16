module Matrix exposing (Matrix, fromArray, fromList, generatePairs, get, horizontalFlip, indexedMap, initialize, toIndexedList, verticalFlip)

{-| Immutable Matrix implementation based on Arrays.
-}

import Array exposing (Array)
import List
import Maybe


type alias Matrix a =
    { data : Array a
    , nrows : Int
    , ncols : Int
    }


{-| Initialize a matrix.
initialize (nrows, ncols) f creates a matrix of size (nrows, ncols)
with the element at index (i, j) initialized to the result of (f (i, j)).
-}
initialize : ( Int, Int ) -> (( Int, Int ) -> a) -> Matrix a
initialize ( nrows, ncols ) f =
    let
        fa k =
            let
                i =
                    k // ncols

                j =
                    k - i * ncols
            in
            f ( i, j )

        data =
            Array.initialize (nrows * ncols) fa
    in
    { data = data
    , nrows = nrows
    , ncols = ncols
    }


{-| Create a new matrix from the array and the number of columns.
-}
fromArray : Array a -> Int -> Matrix a
fromArray array ncols =
    { data = array
    , nrows = Array.length array // ncols
    , ncols = ncols
    }


{-| Create a new matrix from the list and the number of columns.
-}
fromList : List a -> Int -> Matrix a
fromList list =
    fromArray (Array.fromList list)


{-| Create an indexed list from an matrix.
Each element of the matrix will be paired with its index.
-}
toIndexedList : Matrix a -> List ( ( Int, Int ), a )
toIndexedList m =
    let
        indices =
            generatePairs ( 0, m.nrows ) ( 0, m.ncols ) |> List.reverse
    in
    List.map2 (\a b -> ( a, b )) indices (Array.toList m.data)


{-| Get `Just` the element at the index
or `Nothing` if the index is out of range.
-}
get : ( Int, Int ) -> Matrix a -> Maybe a
get idx m =
    let
        mbI =
            getInternalIndex idx m
    in
    case mbI of
        Just i ->
            Array.get i m.data

        Nothing ->
            Nothing


{-| Apply a function on every element with its index as first argument.
-}
indexedMap : (( Int, Int ) -> a -> b) -> Matrix a -> Matrix b
indexedMap f m =
    let
        indices =
            generatePairs ( 0, m.nrows ) ( 0, m.ncols ) |> List.reverse

        data =
            List.map2 f indices (Array.toList m.data)
    in
    fromList data m.ncols


{-| Get `Just` an index of the internal array at the index
or `Nothing` if the index is out of range.
-}
getInternalIndex : ( Int, Int ) -> Matrix a -> Maybe Int
getInternalIndex ( i, j ) m =
    if i >= 0 && i < m.nrows && j >= 0 && j < m.ncols then
        getUnsafeInternalIndex ( i, j ) m |> Just

    else
        Nothing


{-| Calculate index of the internal array without checking bounds.
-}
getUnsafeInternalIndex : ( Int, Int ) -> Matrix a -> Int
getUnsafeInternalIndex ( i, j ) m =
    i * m.ncols + j


{-| Generate all pair of the elements of the given ranges
in reversed order.
-}
generatePairs : ( Int, Int ) -> ( Int, Int ) -> List ( Int, Int )
generatePairs ( minI, maxI ) ( minJ, maxJ ) =
    let
        helper pairs i j =
            if i >= maxI then
                pairs

            else if j >= maxJ then
                helper pairs (i + 1) minJ

            else
                helper (( i, j ) :: pairs) i (j + 1)
    in
    helper [] minI minJ


{-| Flip the matrix vertically.
-}
verticalFlip : Matrix number -> Matrix number
verticalFlip m =
    let
        f ( i, j ) =
            Maybe.withDefault 0 (get ( i, m.ncols - j - 1 ) m)
    in
    initialize ( m.nrows, m.ncols ) f


{-| Flip the matrix horizontally.
-}
horizontalFlip : Matrix number -> Matrix number
horizontalFlip m =
    let
        f ( i, j ) =
            Maybe.withDefault 0 (get ( m.nrows - i - 1, j ) m)
    in
    initialize ( m.nrows, m.ncols ) f
