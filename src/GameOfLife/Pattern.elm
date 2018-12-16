module GameOfLife.Pattern exposing (engine, glider, universe_1)

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
blinker_1 : Matrix Int
blinker_1 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Blinker Universe. Oscillator type with period = 2. State 2.
-}
blinker_2 : Matrix Int
blinker_2 =
    Matrix.fromList [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] 5


{-| Combined universe 1.
-}
universe_1 : Matrix Int
universe_1 =
    batchInitialize ( 70, 70 )
        [ ( ( 10, 10 ), engine )
        , ( ( 5, 40 ), blinker_2 )
        , ( ( 10, 40 ), blinker_1 )
        , ( ( 15, 40 ), blinker_2 )
        , ( ( 20, 40 ), blinker_1 )
        , ( ( 20, 20 ), boat )
        ]
