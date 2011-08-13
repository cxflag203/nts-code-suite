unit UI.Aero.Globals;

interface

type
  TSnapMode = ( smTop, smBottom, smLeft, smRight  );
  
  TCompositionDraw = ( cdNone, cdImage, cdText, cdTheme );

  TToolTipIcon = ( tiNone, tiApplication, tiHand, tiQuestion, tiExclamation, tiAsterisk, tiWinLogo, tiShield );

  TToolTipIconPos = ( tipLeft, tipRight );

  TAeroButtonState = ( bsNormal, bsHightLight, bsFocused, bsDown, bsDisabled );

  TImagePosition = ( ipTopLeft,    ipTopCenter,    ipTopRight,
                     ipCenterLeft, ipCenter,       ipCenterRight,
                     ipBottomLeft, ipBottomCenter, ipBottomRight,
                                   ipStretch                      );

  TAeroBackGround = ( bgSolid, bgGradient, bgTexture );

  TTaskButtonImagePos = ( tbLeft, tbRight );

  TPartOrientation = ( ioHorizontal, ioVertical );

  TRenderState = ( rsGDIP, rsBuffer, rsComposited, rsPostDraw );

  TRenderConfig = set of TRenderState;

  TAnimationStyle = ( asNone, asLinear, asCubic, asSine );

  TARenderState = ( arsGDIP, arsComposited, arsPostDraw );

  TARenderConfig = set of TARenderState;
  
implementation

end.
