module MatrixTests exposing (suite)

import Array
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
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
        ]
