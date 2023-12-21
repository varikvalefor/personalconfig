import Control.Monad;

import XMonad;
import XMonad.Util.Run;
import XMonad.Util.Cursor;
import XMonad.Layout.Grid;
import XMonad.Util.EZConfig;
import XMonad.Hooks.SetWMName;
import XMonad.Hooks.ManageDocks;
import XMonad.Hooks.UrgencyHook;
import XMonad.Hooks.EwmhDesktops;
import XMonad.Actions.CopyWindow;
import XMonad.Hooks.DynamicLog (xmobar);
import XMonad.Layout.NoBorders (noBorders, smartBorders);

myLayout = smartBorders $ Grid ||| noBorders Full ||| Tall 1 (3/100) (1/2);

conph = def {
  modMask = mod4Mask,
  terminal = "xterm",
  layoutHook = myLayout,
  normalBorderColor = "#008080",
  focusedBorderColor = "#00FFFF",
  startupHook = setWMName "LG3D"
  --startupHook = setDefaultCursor xC_shuttle
} `additionalKeysP` keybinds;

keybinds :: [(String, X ())];
keybinds = [("M-a",       windows copyToAll),
            ("M-S-a",     killAllOtherCopies),
            ("M-x c m",   spawn "claws-mail"),
            ("M-x w e b", spawn "(ulimit -d 2048000; su vvx -c iridium)"),
            ("M-x k u t", spawn  "(ulimit -d 1024000; su vvx -c qutebrowser)"),
            ("M-r s n",   spawn "redshift -PO 3000"),
            ("M-x k y s", spawn "sh ~/.scripts/scrot.sh"),
            ("M-r s f",   spawn "redshift -x")];

main = xmonad <=< xmobar $ ewmh conph;
