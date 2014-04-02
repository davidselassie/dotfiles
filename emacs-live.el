(live-use-packs '(stable/foundation-pack     ; Use live-use-packs to control which built-in packs should be loaded
                  stable/colour-pack         ; This built-in pack MUST be disabled if you want to use 3rd party color theme pack
                  stable/lang-pack
                  stable/power-pack
                  stable/git-pack
                  stable/org-pack
                  stable/clojure-pack
                  stable/bindings-pack))
(live-add-packs '(~/.live-packs/selassid-pack))
