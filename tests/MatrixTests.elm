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
        ]
