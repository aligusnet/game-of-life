module GameOfLifeTests exposing (suite)

import Array
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import GameOfLife exposing (transit)
import List
import Matrix exposing (Matrix)
import Test exposing (..)


block : Matrix Int
block =
    Matrix.fromList [ 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0 ] 4


boat : Matrix Int
boat =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


blinker_1 : Matrix Int
blinker_1 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


blinker_2 : Matrix Int
blinker_2 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


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
        ]
