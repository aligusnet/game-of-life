module GameOfLifeTests exposing (suite)

import Array
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import GameOfLife exposing (initialize, transit)
import List
import Matrix exposing (Matrix)
import Test exposing (..)


{-| Block Universe. Still\_live type.
-}
block : Matrix Int
block =
    Matrix.fromList [ 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0 ] 4


{-| Boat Universe. Still\_live type.
-}
boat : Matrix Int
boat =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Blinker Universe. Oscillator type with period = 2. State 1.
-}
blinker_1 : Matrix Int
blinker_1 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Blinker Universe. Oscillator type with period = 2. State 2.
-}
blinker_2 : Matrix Int
blinker_2 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 1.
-}
glider_1 : Matrix Int
glider_1 =
    Matrix.fromList [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 2.
-}
glider_2 : Matrix Int
glider_2 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 3.
-}
glider_3 : Matrix Int
glider_3 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 4.
-}
glider_4 : Matrix Int
glider_4 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Glider Universe. Spaceship type. State 5.
-}
glider_5 : Matrix Int
glider_5 =
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
                Expect.equal blinker_2 (transit blinker_1)
        , test "Blinker Universe oscilates with period = 2" <|
            \_ ->
                blinker_1
                    |> transit
                    |> transit
                    |> Expect.equal blinker_1
        , test "Glider Universe moves. Step 1" <|
            \_ ->
                Expect.equal glider_2 (transit glider_1)
        , test "Glider Universe moves. Step 2" <|
            \_ ->
                Expect.equal glider_3 (transit glider_2)
        , test "Glider Universe moves. Step 3" <|
            \_ ->
                Expect.equal glider_4 (transit glider_3)
        , test "Glider Universe moves. Step 4" <|
            \_ ->
                Expect.equal glider_5 (transit glider_4)
        , test "initialize" <|
            \_ ->
                let
                    pattern =
                        Matrix.fromList [ 1, 0, 0, 1 ] 2

                    expectedMatrix =
                        Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5
                in
                Expect.equal expectedMatrix (initialize ( 4, 5 ) pattern)
        ]
