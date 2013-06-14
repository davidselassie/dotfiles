(live-use-packs '(live/foundation-pack     ; Use live-use-packs to control which built-in packs should be loaded
                  live/colour-pack         ; This built-in pack MUST be disabled if you want to use 3rd party color theme pack
                  live/clojure-pack
                  live/lang-pack
                  live/power-pack))
(live-add-packs '(live/bindings-pack))
(live-add-packs '(~/.live-packs/selassid-pack))
