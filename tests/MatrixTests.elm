module MatrixTests exposing (suite)

import Array
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import List
import Matrix
import Test exposing (..)


suite : Test
suite =
    describe "The Matrix Module"
        [ test "fromArray should correctly calculate number of columns" <|
            \_ ->
                let
                    array =
                        Array.fromList [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

                    matrix =
                        Matrix.fromArray array 5
                in
                Expect.equal 1 matrix.nrows
        , test "given correct index get should return correct value" <|
            \_ ->
                let
                    array =
                        Array.fromList [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

                    matrix =
                        Matrix.fromArray array 2
                in
                Expect.equal (Just 8) (Matrix.get ( 3, 1 ) matrix)
        , test "given incorrect index get should return nothing" <|
            \_ ->
                let
                    array =
                        Array.fromList [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

                    matrix =
                        Matrix.fromArray array 2
                in
                Expect.equal Nothing (Matrix.get ( 2, 2 ) matrix)
        , test "generate pairs test" <|
            \_ ->
                Matrix.generatePairs ( 0, 3 ) ( 0, 2 )
                    |> List.reverse
                    |> Expect.equal [ ( 0, 0 ), ( 0, 1 ), ( 1, 0 ), ( 1, 1 ), ( 2, 0 ), ( 2, 1 ) ]
        , test "indexed map" <|
            \_ ->
                let
                    matrix =
                        Matrix.fromList [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] 2

                    f ( i, j ) value =
                        i * 100 + j * 10 + value

                    expectedMatrix =
                        Matrix.fromList [ 1, 12, 103, 114, 205, 216, 307, 318 ] 2
                in
                Expect.equal expectedMatrix (Matrix.indexedMap f matrix)
        , test "to indexed list" <|
            \_ ->
                let
                    matrix =
                        Matrix.fromList [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ] 2

                    expectedIndexedList =
                        [ ( ( 0, 0 ), 1 ), ( ( 0, 1 ), 2 ), ( ( 1, 0 ), 3 ), ( ( 1, 1 ), 4 ), ( ( 2, 0 ), 5 ), ( ( 2, 1 ), 6 ), ( ( 3, 0 ), 7 ), ( ( 3, 1 ), 8 ) ]
                in
                Expect.equal expectedIndexedList (Matrix.toIndexedList matrix)
        , test "initialize" <|
            \_ ->
                let
                    expectedMatrix =
                        Matrix.fromList [ 0, 1, 2, 10, 11, 12, 20, 21, 22, 30, 31, 32 ] 3

                    f ( i, j ) =
                        i * 10 + j
                in
                Expect.equal expectedMatrix (Matrix.initialize ( 4, 3 ) f)
        , test "vertical flip" <|
            \_ ->
                let
                    matrix =
                        Matrix.fromList [ 0, 1, 2, 3, 4, 5 ] 3

                    expectedMatrix =
                        Matrix.fromList [ 2, 1, 0, 5, 4, 3 ] 3
                in
                Expect.equal expectedMatrix (Matrix.verticalFlip matrix)
        , test "horizontal flip" <|
            \_ ->
                let
                    matrix =
                        Matrix.fromList [ 0, 1, 2, 3, 4, 5 ] 3

                    expectedMatrix =
                        Matrix.fromList [ 3, 4, 5, 0, 1, 2 ] 3
                in
                Expect.equal expectedMatrix (Matrix.horizontalFlip matrix)
        ]
