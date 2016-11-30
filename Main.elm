import Random exposing (Seed, initialSeed, step, int)
import Time exposing (Time, now, every, second)
import Task exposing (perform)
import Html exposing (Html, div, text, b)

type alias Model =
  { time : Time
  , seed : Seed
  , rand : Int }

type Msg = Tick Time

generator = Random.int 1 6

init : (Model, Cmd Msg)
init = ( { time = 0
         , seed = initialSeed 0
         , rand = 0 }
       , perform Tick now)

update : Msg -> Model -> (Model, Cmd Msg)
update msg old_model = case msg of Tick t ->
  let (rand, seed) = step generator old_model.seed
  in ( { time = t
       , seed = seed
       , rand = rand }
     , Cmd.none)

view : Model -> Html Msg
view model = div []
  [ div []
    [ text "The time is: "
    , b [] [ text <| toString model.time ] ]
  , div []
    [ text "Die roll: "
    , b [] [ text <| toString model.rand ] ] ]

main = Html.program
  { init = init
  , update = update
  , view = view
  , subscriptions = \_ -> every second Tick }
