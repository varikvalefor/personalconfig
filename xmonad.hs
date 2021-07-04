import XMonad;
import XMonad.Util.Run;
import XMonad.Util.Cursor;
import XMonad.Layout.Grid;
import XMonad.Util.EZConfig;
import XMonad.Hooks.SetWMName;
import XMonad.Hooks.ManageDocks;
import XMonad.Hooks.UrgencyHook;
import XMonad.Actions.CopyWindow;
import XMonad.Hooks.DynamicLog (xmobar);
import XMonad.Layout.NoBorders (noBorders, smartBorders);

myLayout =
  smartBorders $
  Grid ||| noBorders Full ||| Tall 1 (3/100) (1/2);

conph = def {
  modMask = mod4Mask,
  terminal = "xterm",
  layoutHook = myLayout,
  normalBorderColor = "#008080",
  focusedBorderColor = "#00FFFF",
  startupHook = setDefaultCursor xC_shuttle
} `additionalKeysP` keybinds;

keybinds :: [(String, X ())];
keybinds =
  [
    ("M-a",       windows copyToAll),
    ("M-S-a",     killAllOtherCopies),
    ("M-x c m",   spawn "claws-mail"),
    ("M-x w e b", spawn "su vvx -c iridium")
  ];
