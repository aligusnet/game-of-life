module GameOfLife.Pattern exposing (blinker1, blinker2, boat, engine, glider, gosperGliderGun, pulsar, universe1, universe2)

import GameOfLife exposing (batchInitialize, initializeWithLiveCells)
import Matrix exposing (Matrix)


{-| Glider Universe. Spaceship type. State 1.
-}
glider : Matrix Int
glider =
    Matrix.fromList [ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Engine Universe. Evolves forever.
-}
engine : Matrix Int
engine =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 8


{-| Boat Universe. Still-live type.
-}
boat : Matrix Int
boat =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Blinker Universe. Oscillator type with period = 2. State 1.
-}
blinker1 : Matrix Int
blinker1 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Blinker Universe. Oscillator type with period = 2. State 2.
-}
blinker2 : Matrix Int
blinker2 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Pulsar Universe. Oscillator type with period = 3. State 1.
-}
pulsar : Matrix Int
pulsar =
    let
        pulsarPart1 =
            Matrix.fromList [ 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0 ] 6

        pulsarPart2 =
            Matrix.verticalFlip pulsarPart1

        pulsarPart3 =
            Matrix.horizontalFlip pulsarPart2

        pulsarPart4 =
            Matrix.verticalFlip pulsarPart3
    in
    batchInitialize ( 17, 17 )
        [ ( ( 2, 2 ), pulsarPart1 )
        , ( ( 2, 9 ), pulsarPart2 )
        , ( ( 9, 9 ), pulsarPart3 )
        , ( ( 9, 2 ), pulsarPart4 )
        ]


{-| Combined universe 1.
-}
universe1 : Matrix Int
universe1 =
    batchInitialize ( 50, 50 )
        [ ( ( 20, 10 ), engine )
        , ( ( 5, 40 ), blinker2 )
        , ( ( 10, 40 ), blinker1 )
        , ( ( 15, 40 ), blinker2 )
        , ( ( 20, 40 ), blinker1 )
        , ( ( 30, 40 ), boat )
        ]


{-| Combined universe 2 based on Pulsar.
-}
universe2 : Matrix Int
universe2 =
    batchInitialize ( 20, 37 )
        [ ( ( 0, 0 ), blinker1 )
        , ( ( 5, 0 ), blinker2 )
        , ( ( 10, 0 ), blinker1 )
        , ( ( 15, 0 ), blinker2 )
        , ( ( 2, 10 ), pulsar )
        , ( ( 0, 32 ), blinker1 )
        , ( ( 5, 32 ), blinker2 )
        , ( ( 10, 32 ), blinker1 )
        , ( ( 15, 32 ), blinker2 )
        ]


{-| Gosper glider gun grows indefinitely
-}
gosperGliderGun : Matrix Int
gosperGliderGun =
    let
        cells =
            [ ( 5, 1 )
            , ( 5, 2 )
            , ( 6, 1 )
            , ( 6, 2 )
            , ( 3, 13 )
            , ( 3, 14 )
            , ( 4, 12 )
            , ( 5, 11 )
            , ( 6, 11 )
            , ( 7, 11 )
            , ( 8, 12 )
            , ( 9, 13 )
            , ( 9, 14 )
            , ( 6, 15 )
            , ( 4, 16 )
            , ( 8, 16 )
            , ( 5, 17 )
            , ( 6, 17 )
            , ( 7, 17 )
            , ( 6, 18 )
            , ( 3, 21 )
            , ( 4, 21 )
            , ( 5, 21 )
            , ( 3, 22 )
            , ( 4, 22 )
            , ( 5, 22 )
            , ( 2, 23 )
            , ( 6, 23 )
            , ( 1, 25 )
            , ( 2, 25 )
            , ( 6, 25 )
            , ( 7, 25 )
            , ( 3, 35 )
            , ( 4, 35 )
            , ( 3, 36 )
            , ( 4, 36 )
            ]
    in
    initializeWithLiveCells ( 50, 50 ) cells
