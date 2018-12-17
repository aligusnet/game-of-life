module GameOfLifeTests exposing (suite)

import Array
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import GameOfLife exposing (batchInitialize, initialize, initializeWithLiveCells, transit)
import GameOfLife.Pattern exposing (blinker1, blinker2, boat, glider)
import Matrix exposing (Matrix)
import Test exposing (..)


{-| Block Universe. Still-live type.
-}
block : Matrix Int
block =
    Matrix.fromList [ 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0 ] 4


{-| Glider Universe. Spaceship type. State 2.
-}
glider2 : Matrix Int
glider2 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 3.
-}
glider3 : Matrix Int
glider3 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 4.
-}
glider4 : Matrix Int
glider4 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 5.
-}
glider5 : Matrix Int
glider5 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0 ] 5


suite : Test
suite =
    describe "The GameOfLife Module"
        [ test "Block Universe stays the same" <|
            \_ ->
                Expect.equal block (transit block)
        , test "Boat Universe stays the same" <|
            \_ ->
                Expect.equal boat (transit boat)
        , test "Blinker Universe does not staty the same" <|
            \_ ->
                Expect.equal blinker2 (transit blinker1)
        , test "Blinker Universe oscilates with period = 2" <|
            \_ ->
                blinker1
                    |> transit
                    |> transit
                    |> Expect.equal blinker1
        , test "Glider Universe moves. Step 1" <|
            \_ ->
                Expect.equal glider2 (transit glider)
        , test "Glider Universe moves. Step 2" <|
            \_ ->
                Expect.equal glider3 (transit glider2)
        , test "Glider Universe moves. Step 3" <|
            \_ ->
                Expect.equal glider4 (transit glider3)
        , test "Glider Universe moves. Step 4" <|
            \_ ->
                Expect.equal glider5 (transit glider4)
        , test "initialize" <|
            \_ ->
                let
                    pattern =
                        Matrix.fromList [ 1, 0, 0, 1 ] 2

                    expectedMatrix =
                        Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5
                in
                Expect.equal expectedMatrix (initialize ( 4, 5 ) pattern)
        , test "batch initialize" <|
            \_ ->
                let
                    pattern1 =
                        Matrix.fromList [ 1, 0, 0, 1 ] 2

                    offsets1 =
                        ( 1, 1 )

                    pattern2 =
                        Matrix.fromList [ 1, 1, 1, 1, 1, 1 ] 2

                    offsets2 =
                        ( 2, 1 )

                    expectedMatrix =
                        Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0 ] 5

                    patterns =
                        [ ( offsets1, pattern1 ), ( offsets2, pattern2 ) ]
                in
                Expect.equal expectedMatrix (batchInitialize ( 4, 5 ) patterns)
        , test "initialize with live cells" <|
            \_ ->
                let
                    liveCells =
                        [ ( 0, 0 ), ( 1, 1 ), ( 1, 2 ), ( 2, 0 ) ]

                    expectedMatrix =
                        Matrix.fromList [ 1, 0, 0, 0, 1, 1, 1, 0, 0 ] 3
                in
                Expect.equal expectedMatrix (initializeWithLiveCells ( 3, 3 ) liveCells)
        ]
