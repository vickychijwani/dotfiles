* Introduction
Tabbar ruler is an emacs package that allows both the tabbar and the
ruler to be used together.  In addition it allows auto-hiding of the
menu-bar and tool-bar.


Tabbar appearance based on reverse engineering Aquaemacs code and
changing to my preferences, and Emacs Wiki.

Tabbar/Ruler integration is new. Tabbar should be active on mouse
move.  Ruler should be active on self-insert commands.

Also allows auto-hiding of toolbar and menu.

To use this, put the library in your load path and use


  (setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
  (setq tabbar-ruler-global-ruler 't) ; if you want a global ruler
  (setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.
  (setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar

  (require 'tabbar-ruler)




* Known issues
the left arrow is text instead of an image.
