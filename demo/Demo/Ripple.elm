module Demo.Ripple exposing (Model, defaultModel, Msg(Mdc), update, view)

import Html exposing (Html, text)
import Material
import Material.Elevation as Elevation
import Material.Options as Options exposing (styled, cs, css)
import Material.Ripple as Ripple
import Demo.Page as Page exposing (Page)


-- MODEL


type alias Model =
    { mdc : Material.Model
    }


defaultModel : Model
defaultModel =
    { mdc = Material.defaultModel
    }


type Msg m
    = Mdc (Material.Msg m)


update : (Msg m -> m) -> Msg m -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (Mdc >> lift) msg_ model


-- VIEW


view : (Msg m -> m) -> Page m -> Model -> Html m
view lift page model =
    let
        demoSurface =
            Options.many
            [ cs "demo-surface"
            , css "display" "flex"
            , css "align-items" "center"
            , css "justify-content" "center"
            , css "width" "200px"
            , css "height" "100px"
            , css "padding" "1rem"
            , css "cursor" "pointer"
            , css "user-select" "none"
            , css "-webkit-user-select" "none"
            ]

        example options =
            styled Html.section
            ( cs "example"
            :: css "display" "flex"
            :: css "flex-flow" "column"
            :: css "margin" "24px"
            :: css "padding" "24px"
            :: options
            )
    in
    page.body "Ripple"
    [
      Page.hero []
      [
        let
            ripple =
                Ripple.bounded (Mdc >> lift) [0] model.mdc () ()
        in
        styled Html.div
        [ css "width" "100%"
        , css "height" "100%"
        , ripple.interactionHandler
        , ripple.properties
        , Ripple.surface
        ]
        [ ripple.style
        ]
      ]

    ,
      example []
      [ Html.h2 [] [ text "Bounded" ]
      , let
            ripple =
                Ripple.bounded (Mdc >> lift) [1] model.mdc () ()
        in
        styled Html.div
        [ demoSurface
        , Elevation.z2
        , ripple.interactionHandler
        , ripple.properties
        , Ripple.surface
        ]
        [ text "Interact with me!"
        , ripple.style
        ]
      ]

    , example []
      [ Html.h2 [] [ text "Unbounded" ]
      , let
            ripple =
                Ripple.unbounded (Mdc >> lift) [2] model.mdc () ()
        in
        styled Html.div
        [ cs "material-icons"
        , css "width" "24px"
        , css "height" "24px"
        , css "padding" "12px"
        , css "border-radius" "50%"
        , demoSurface
        , ripple.interactionHandler
        , ripple.properties
        , Ripple.surface
        ]
        [ text "favorite"
        , ripple.style
        ]
      ]

    , example []
      [ Html.h2 [] [ text "Theme Styles" ]
      , let
            ripple =
                Ripple.bounded (Mdc >> lift) [3] model.mdc () ()
        in
        styled Html.div
        [ demoSurface
        , Elevation.z2
        , ripple.interactionHandler
        , ripple.properties
        , Ripple.surface
        , Ripple.primary
        ]
        [ text "Primary"
        , ripple.style
        ]
      , let
            ripple =
                Ripple.bounded (Mdc >> lift) [4] model.mdc () ()
        in
        styled Html.div
        [ demoSurface
        , Elevation.z2
        , ripple.interactionHandler
        , ripple.properties
        , Ripple.surface
        , Ripple.accent
        ]
        [ text "Accent"
        , ripple.style
        ]
      ]
    ]