import XMonad
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Layout.Fullscreen
import XMonad.Util.Run  
import System.IO  
import System.Exit
import XMonad.Util.EZConfig

import qualified Data.Map        as M

-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
	-- Quit xmonad
	[ ((modm .|. shiftMask, xK_e     ), io (exitWith ExitSuccess))
	, ((modm .|. shiftMask, xK_w     ), safeSpawnProg "firefox")
	, ((modm , xK_p     ), safeSpawnProg "i3-dmenu-desktop")
	]

myWorkspaces = ["1:main","2:chat","3","whatever","5:media","6","7","8:web"]

myLayout = fullscreenFull tiled ||| Mirror tiled ||| Full  
 where  
      -- default tiling algorithm partitions the screen into two panes  
      tiled = spacing 10 $ Tall nmaster delta ratio  
   
      -- The default number of windows in the master pane  
      nmaster = 1  
   
      -- Default proportion of screen occupied by master pane  
      ratio = 2/3  
   
      -- Percent of screen to increment by when resizing panes  
      delta = 5/100  

startup :: X ()
startup = do
          spawn "~/xinitrc/autostart"
          spawn "~/xinitrc/autostart-xmonad"

main = do
xmproc <- spawnPipe "/usr/bin/xmobar"   
xmonad $ defaultConfig
    { startupHook       = startup
	, handleEventHook = fullscreenEventHook
    , manageHook = manageDocks <+> fullscreenManageHook <+> manageHook defaultConfig  
    , layoutHook = avoidStruts $ myLayout  
    , logHook = dynamicLogWithPP xmobarPP  
         { ppOutput = hPutStrLn xmproc  
         , ppTitle = xmobarColor "blue" "" . shorten 50   
         , ppLayout = const "" -- to disable the layout info on xmobar 
         }
	, keys				= myKeys <+> keys defaultConfig 
    , terminal          = "urxvt"
    , workspaces        = myWorkspaces
    , borderWidth       = 5
    , normalBorderColor = "#8d8d8d"
    , focusedBorderColor = "#35afff"
    }
	`removeKeysP` ["M-S-q"]
