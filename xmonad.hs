import XMonad;
import XMonad.Util.Run;
import XMonad.Layout.Grid;
import XMonad.Hooks.ManageDocks;
import XMonad.Hooks.UrgencyHook;
import XMonad.Hooks.DynamicLog (xmobar);
import XMonad.Layout.NoBorders (noBorders, smartBorders);

myLayout =
  smartBorders $
  Grid ||| noBorders Full ||| Tall 1 (3/100) (1/2)

conph = def {
  modMask = mod4Mask
  , terminal = "starch"
  , layoutHook = myLayout
  , normalBorderColor = "#008080"
  , focusedBorderColor = "#00FFFF"
}

main = xmonad conph;
