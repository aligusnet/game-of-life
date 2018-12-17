module GameOfLife.Pattern exposing (blinker1, blinker2, boat, engine, glider, pulsar, universe1, universe2)

import GameOfLife exposing (batchInitialize)
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
    batchInitialize ( 70, 70 )
        [ ( ( 10, 10 ), engine )
        , ( ( 5, 40 ), blinker2 )
        , ( ( 10, 40 ), blinker1 )
        , ( ( 15, 40 ), blinker2 )
        , ( ( 20, 40 ), blinker1 )
        , ( ( 20, 20 ), boat )
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
