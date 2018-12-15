module Matrix exposing (Matrix, fromArray, fromList, get)

{-| Immutable Matrix implementation based on Arrays.
-}

import Array exposing (Array)


type alias Matrix a =
    { data : Array a
    , nrows : Int
    , ncols : Int
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


{-| Get `Just` the element at the index
or `Nothing` if the index is out of range.
-}
get : ( Int, Int ) -> Matrix a -> Maybe a
get ( i, j ) m =
    if i >= 0 && i < m.nrows && j >= 0 && j < m.ncols then
        Array.get (i * m.ncols + j) m.data

    else
        Nothing
