// -------------------------------------------------------
//
// "NEVATO" theme for Attract-Mode Front-End
// version 1.0
// 
// graphic design and coding = www.ClanLogoDesign.com
// cabinet design and photo = www.tenDESIGN.pro
//
// read more at www.ONYXarcade.com/nevato
//
// spinwheel code forked from omegaman's "ROBOSPIN" theme
//
// -------------------------------------------------------
//
// this theme is free for private use only
// and can be distributed only with Attract Mode front-end
// for other uses please contact ONYXarcade.com for permission
//
// -------------------------------------------------------
//
// special thanks to omegaman for ROBOSPIN theme
// without it - we wouldn't be able to learn how
// to code AM themes
//
// -------------------------------------------------------


class UserConfig {

</ label="NEVATO theme", help=" ", options=" ", order=1 /> divider1="";
</ label="- - -", help=" ", options=" ", order=1 /> divider1="";
//-----------------------------------------------------------------
</ label="mute videos snaps sound", help="yes = sound disabled, no = sound enabled", options="yes,no", order=2 /> mute_videoSnaps="no";

</ label="- - -", help=" ", options=" ", order=3 /> divider2="";
//-----------------------------------------------------------------
</ label="cab screen", help="video = video snap, screenshot = game screenshot", options="video, screenshot", order=4 /> cabScreenType="video";
</ label="scanlines on screen", help="show scanlines effect on cab screen.", options="light,medium,dark,off", order=5 /> enable_scanlines="light";

</ label="- - -", help=" ", options=" ", order=6 /> divider3="";
//-----------------------------------------------------------------
</ label="marquee artwork", help="marquee type, replace ''my-own-marquee.jpg'' file with your own", options="marquee,emulator-name,my-own", order=7 /> marquee_type="marquee"; 
 
</ label="- - -", help=" ", options=" ", order=9 /> divider4="";
//-----------------------------------------------------------------
</ label="LCD right side", help="what's on right side of LCD", options="filter, emulator, display-name, rom-filename, off,", order=10 /> lcdRight="filter"; 

</ label="- - -", help=" ", options=" ", order=11 /> divider5="";
//-----------------------------------------------------------------
</ label="spinwheel artwork", help="marquee or wheel", options="marquee,wheel", order=12 /> spinwheelArt="wheel";
</ label="speenwheel transition time", help="Time in milliseconds for wheel spin.", order=13 /> transition_ms="80";
   
</ label="- - -", help=" ", options=" ", order=14 /> divider6="";
//-----------------------------------------------------------------
</ label="background art", help="Display the flyer/fanart/snap(screenshot)/video in background.", options="flyer,fanart,snap,video,none", order=15 /> enable_bg_art="fanart";
</ label="background ststic image", help="background image if there is no background art", options="blue,black,none", order=16 /> enable_static_bkg="black";
</ label="background mask", help="make background medium or dark", options="dark,medium", order=17 /> enable_mask="dark";

</ label="- - -", help=" ", options=" ", order=18 /> divider7="";
//-----------------------------------------------------------------
}  


local my_config = fe.get_config();


fe.load_module( "fade" );

local blip = fe.layout.height;
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;


//fe.layout.width = 1920;
//fe.layout.height = 1080;






//coordinates table for different screen aspects -------------------------- START



local settings = {
   "default": {
      aspectDepend = { 
        snap_skewX = 42.0, 
        snap_skewY = -8.0, 

        snap_pinchX = 0, 
        snap_pinchY = 29.0, 
        snap_rotation = 0.9, 

        marquee_skewX = 17, 
        marquee_skewY = 0, 
        marquee_pinchX = -2, 
        marquee_pinchY = 7, 
        marquee_rotation = 6.2, 

        wheelNumElements = 10 }
   },
   "16x10": {
      aspectDepend = { 
        res_x = 1920,
        res_y = 1200,

        maskFactor = 1.9,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 10 }
   },
    "16x9": {
      aspectDepend = { 
        res_x = 2133,
        res_y = 1200,

        maskFactor = 1.9,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 8 }
   },
   "4x3": {
      aspectDepend = { 
        res_x = 1600,
        res_y = 1200,

        maskFactor = 1.6,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 10 }
   }
   "5x4": {
      aspectDepend = { 
        res_x = 1500,
        res_y = 1200,

        maskFactor = 1.6,

        snap_skewX = 62.5, 
        snap_skewY = -12.9, 
        snap_pinchX = 0, 
        snap_pinchY = 40.0, 
        snap_rotation = 1.0, 

        wheelNumElements = 10 }
   }
}




local aspect = fe.layout.width / fe.layout.height.tofloat();
print (aspect);
local aspect_name = "";
switch( aspect.tostring() )
{
    case "1.77865":  //for 1366x768 screen
    case "1.77778":  //for any other 16x9 resolution
        aspect_name = "16x9";
        break;
    case "1.6":
        aspect_name = "16x10";
        break;
    case "1.33333":
        aspect_name = "4x3";
        break;
    case "1.25":
        aspect_name = "5x4";
        break;
    case "0.75":
        aspect_name = "3x4";
        break;
}


function Setting( id, name )
{
    if ( aspect_name in settings && id in settings[aspect_name] && name in settings[aspect_name][id] )
  {
    ::print("\tusing settings[" + aspect_name + "][" + id + "][" + name + "] : " + settings[aspect_name][id][name] + "\n" );
    return settings[aspect_name][id][name];
  } else if ( aspect_name in settings == false )
  {
    ::print("\tsettings[" + aspect_name + "] does not exist\n");
  } else if ( name in settings[aspect_name][id] == false )
  {
    ::print("\tsettings[" + aspect_name + "][" + id + "][" + name + "] does not exist\n");
  }
  ::print("\t\tusing default value: " + settings["default"][id][name] + "\n" );
  return settings["default"][id][name];
}




fe.layout.width = Setting("aspectDepend", "res_x");
fe.layout.height = Setting("aspectDepend", "res_y");

local blip = fe.layout.height;

local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;

local mask_factor = Setting("aspectDepend", "maskFactor");


//coordinates table for different screen aspects -------------------------- END









// mute audio variable - definable via user config ------------------------ START

if ( my_config["mute_videoSnaps"] == "yes") 
{
::videoSound <- Vid.NoAudio;
}
if ( my_config["mute_videoSnaps"] == "no") 
{
::videoSound <- Vid.Default;
}

// mute audio variable - definable via user config ------------------------ END







// default background image (if background art is not enabled) ------------- START

if ( my_config["enable_static_bkg"] == "blue") 
{
 local bg = fe.add_image( "background_blue.png", 0, 0, flw, flh );
}
if ( my_config["enable_static_bkg"] == "black")
{
 local bg = fe.add_image( "background_black.png", 0, 0, flw, flh );
}
if ( my_config["enable_static_bkg"] == "none") 
{
 local bg = fe.add_image( "", 0, 0, flw, flh );
}

// default background image (if background art is not enabled) ------------- END







// background art --------------------------------------------------------- START

if ( my_config["enable_bg_art"] == "flyer") 
{
 local bgart = fe.add_artwork( "flyer", flw*0.2, flw*0, flw*0.6, 0);
 bgart.preserve_aspect_ratio = true;
 local mask = fe.add_image( "mask_edges.png", 0 , 0, mask_factor*flh, flh );  //gradient to mask left and right edge of the flyer 1.6 for 4:3 and 16:10  1.9 for 16:9
 mask.preserve_aspect_ratio = false;
}



if ( my_config["enable_bg_art"] == "fanart") 
{
 local bgart = FadeArt( "fanart", 0, 0, 0, flh);
 bgart.preserve_aspect_ratio = true;
 local mask = fe.add_image( "mask_edges.png", 0 , 0, mask_factor*flh, flh );  //gradient to mask left and right edge of the flyer
 mask.preserve_aspect_ratio = false;
 //mask.alpha = 255;
}



if ( my_config["enable_bg_art"] == "snap") 
{
 local bgart = fe.add_artwork( "snap", flx-flh*1.34, 0, flh*1.34, 0);
 bgart.preserve_aspect_ratio = true;
 bgart.video_flags=Vid.ImagesOnly;
}



if ( my_config["enable_bg_art"] == "video") 
{
 local bgart = fe.add_artwork( "snap", flx-flh*1.34, 0, flh*1.34, 0);
 bgart.preserve_aspect_ratio = true;
 bgart.video_flags = videoSound;
}


// background art --------------------------------------------------------- END






//masking background (adding scanlines and vignette) -------------------- START

if ( my_config["enable_mask"] == "none" )
{
local masking = fe.add_image( "", 0, 0, flw, 0 );
}


if ( my_config["enable_mask"] == "medium" )
{
local masking = fe.add_image( "background_mask.png", 0, 0, flx, fly );
masking.preserve_aspect_ratio = false;
masking.alpha = 150;           // here you can change mask opacity light=100, medium=150, dark (default)=255
local maskingMedium = fe.add_image( "background_mask_medium.png", 0, 0, flx, fly );
maskingMedium.preserve_aspect_ratio = false;
}


if ( my_config["enable_mask"] == "dark" )
{
local masking = fe.add_image( "background_mask.png", 0, 0, flx,fly);   //for 4:3 fix 1.6*fly
masking.preserve_aspect_ratio = false;
masking.alpha = 255;           // here you can change mask opacity light=100, medium=150, dark (default)=255
}

//masking background (adding scanlines and vignette) -------------------- END







//static tv effect on cab screen snap change (of if no snap at all) ------------- START

local tvStatic = fe.add_image( "static.jpg", blip*0.0984, blip*0.24, blip*0.405, blip*0.3536);
tvStatic.skew_x = Setting("aspectDepend", "snap_skewX");
tvStatic.skew_y = Setting("aspectDepend", "snap_skewY");
tvStatic.pinch_x = Setting("aspectDepend", "snap_pinchX");
tvStatic.pinch_y = Setting("aspectDepend", "snap_pinchY");
tvStatic.rotation = Setting("aspectDepend", "snap_rotation");





//snap (video or screenshot) on cab screen ------------- START

local cabScreen = fe.add_artwork ("snap", blip*0.0984, blip*0.24, blip*0.405, blip*0.3536);
cabScreen.skew_x = Setting("aspectDepend", "snap_skewX");
cabScreen.skew_y = Setting("aspectDepend", "snap_skewY");
cabScreen.pinch_x = Setting("aspectDepend", "snap_pinchX");
cabScreen.pinch_y = Setting("aspectDepend", "snap_pinchY");
cabScreen.rotation = Setting("aspectDepend", "snap_rotation");
cabScreen.trigger = Transition.EndNavigation;
cabScreen.preserve_aspect_ratio = false;

cabScreen.video_flags = videoSound;

if ( my_config["cabScreenType"] == "screenshot" )
{
cabScreen.video_flags=Vid.ImagesOnly;
}





//scanlines over cab screen --------------------------- START

if ( my_config["enable_scanlines"] == "light" )
{
local scanlines = fe.add_image( "scanlines.png", blip*0.0984, blip*0.24, blip*0.405, blip*0.3536 );
scanlines.skew_x = Setting("aspectDepend", "snap_skewX");
scanlines.skew_y = Setting("aspectDepend", "snap_skewY");
scanlines.pinch_x = Setting("aspectDepend", "snap_pinchX");
scanlines.pinch_y = Setting("aspectDepend", "snap_pinchY");
scanlines.rotation = Setting("aspectDepend", "snap_rotation");
scanlines.preserve_aspect_ratio = false;
scanlines.alpha = 50;
}

if ( my_config["enable_scanlines"] == "medium" )
{
local scanlines = fe.add_image( "scanlines.png", blip*0.0984, blip*0.24, blip*0.405, blip*0.3536 );
scanlines.skew_x = Setting("aspectDepend", "snap_skewX");
scanlines.skew_y = Setting("aspectDepend", "snap_skewY");
scanlines.pinch_x = Setting("aspectDepend", "snap_pinchX");
scanlines.pinch_y = Setting("aspectDepend", "snap_pinchY");
scanlines.rotation = Setting("aspectDepend", "snap_rotation");
scanlines.preserve_aspect_ratio = false;
scanlines.alpha = 150;
}

if ( my_config["enable_scanlines"] == "dark" )
{
local scanlines = fe.add_image( "scanlines.png", blip*0.0984, blip*0.24, blip*0.405, blip*0.3536 );
scanlines.skew_x = Setting("aspectDepend", "snap_skewX");
scanlines.skew_y = Setting("aspectDepend", "snap_skewY");
scanlines.pinch_x = Setting("aspectDepend", "snap_pinchX");
scanlines.pinch_y = Setting("aspectDepend", "snap_pinchY");
scanlines.rotation = Setting("aspectDepend", "snap_rotation");
scanlines.preserve_aspect_ratio = false;
scanlines.alpha = 200;
}

//scanlines over cab screen --------------------------- END






//marquee  ------------------------------------------ START

if ( my_config["marquee_type"] == "marquee" )
{
local marqueeBkg = fe.add_image("black.png", blip*0.1032, blip*0.0763, blip*0.3984, blip*0.1349 );
marqueeBkg.skew_x = Setting("aspectDepend", "marquee_skewX");
marqueeBkg.skew_y = Setting("aspectDepend", "marquee_skewY");
marqueeBkg.pinch_x = Setting("aspectDepend", "marquee_pinchX");
marqueeBkg.pinch_y = Setting("aspectDepend", "marquee_pinchY");
marqueeBkg.rotation = Setting("aspectDepend", "marquee_rotation");
marqueeBkg.trigger = Transition.EndNavigation;
marqueeBkg.preserve_aspect_ratio = false;

local marquee = FadeArt("marquee", blip*0.1032, blip*0.0763, blip*0.3984, blip*0.1349 );
marquee.skew_x = Setting("aspectDepend", "marquee_skewX");
marquee.skew_y = Setting("aspectDepend", "marquee_skewY");
marquee.pinch_x = Setting("aspectDepend", "marquee_pinchX");
marquee.pinch_y = Setting("aspectDepend", "marquee_pinchY");
marquee.rotation = Setting("aspectDepend", "marquee_rotation");
marquee.trigger = Transition.EndNavigation;
marquee.preserve_aspect_ratio = false;
}

//marquee  ------------------------------------------ END



//marquee (with emulator name)   ---------------------- START

if ( my_config["marquee_type"] == "emulator-name" )

{
local emuMarquee = fe.add_image("[Emulator]" + "-marquee.jpg", blip*0.1032, blip*0.0763, blip*0.3984, blip*0.1349 );
emuMarquee.skew_x = Setting("aspectDepend", "marquee_skewX");
emuMarquee.skew_y = Setting("aspectDepend", "marquee_skewY");
emuMarquee.pinch_x = Setting("aspectDepend", "marquee_pinchX");
emuMarquee.pinch_y = Setting("aspectDepend", "marquee_pinchY");
emuMarquee.rotation = Setting("aspectDepend", "marquee_rotation");
emuMarquee.trigger = Transition.EndNavigation;
emuMarquee.preserve_aspect_ratio = false;
}



//marquee (my own image) ----------------------------- START

if ( my_config["marquee_type"] == "my-own" )
{
local myOwnMarquee = fe.add_image("my-own-marquee.jpg", blip*0.1032, blip*0.0763, blip*0.3984, blip*0.1349 );
myOwnMarquee.skew_x = Setting("aspectDepend", "marquee_skewX");
myOwnMarquee.skew_y = Setting("aspectDepend", "marquee_skewY");
myOwnMarquee.pinch_x = Setting("aspectDepend", "marquee_pinchX");
myOwnMarquee.pinch_y = Setting("aspectDepend", "marquee_pinchY");
myOwnMarquee.rotation = Setting("aspectDepend", "marquee_rotation");
myOwnMarquee.trigger = Transition.EndNavigation;
myOwnMarquee.preserve_aspect_ratio = false;
}






//cabinet image -------------------------------------- START
local cab = fe.add_image( "cab_body.png", 0, 0, blip*0.992, blip*1.008);
cab.preserve_aspect_ratio = true;







//LCD display text under cab screen ------------------------------------------------ START

local lcdLeftText = fe.add_text( "PLAYED: " + "[PlayedCount]", blip*0.1536, blip*0.6108, blip*0.48, blip*0.04 );  // here you can change what is displayed on left side
lcdLeftText.set_rgb( 59, 45, 3 );
lcdLeftText.align = Align.Left;  
lcdLeftText.rotation = -6.5;
lcdLeftText.font="digital-7 (italic)";  // free font (for personal use) - can be downloaded here: http://www.dafont.com/digital-7.font



if ( my_config["lcdRight"] == "filter" )
{
local lcdRightText = fe.add_text( "[FilterName]", blip*0.1584, blip*0.6108, blip*0.4, blip*0.04 );
lcdRightText.set_rgb( 59, 45, 3 );
lcdRightText.align = Align.Right;
lcdRightText.rotation = -6.6;
lcdRightText.font="digital-7 (italic)";  // free font (for personal use) - can be downloaded here: http://www.dafont.com/digital-7.font
}


if ( my_config["lcdRight"] == "rom-filename" )
{
local lcdRightText = fe.add_text( "[Name]", blip*0.1584, blip*0.6208, blip*0.4, blip*0.04 );
lcdRightText.set_rgb( 59, 45, 3 );
lcdRightText.align = Align.Right;
lcdRightText.rotation = -6.6;
lcdRightText.font="digital-7 (italic)";  // free font (for personal use) - can be downloaded here: http://www.dafont.com/digital-7.font
}


if ( my_config["lcdRight"] == "display-name" )
{
local lcdRightText = fe.add_text( "[DisplayName]", blip*0.1584, blip*0.6208, blip*0.4, blip*0.04 );
lcdRightText.set_rgb( 59, 45, 3 );
lcdRightText.align = Align.Right;
lcdRightText.rotation = -6.6;
lcdRightText.font="digital-7 (italic)";  // free font (for personal use) - can be downloaded here: http://www.dafont.com/digital-7.font
}


if ( my_config["lcdRight"] == "emulator" )
{
local lcdRightText = fe.add_text( "[Emulator]", blip*0.1584, blip*0.6208, blip*0.4, blip*0.04 );
lcdRightText.set_rgb( 59, 45, 3 );
lcdRightText.align = Align.Right;
lcdRightText.rotation = -6.6;
lcdRightText.font="digital-7 (italic)";  // free font (for personal use) - can be downloaded here: http://www.dafont.com/digital-7.font
}


if ( my_config["lcdRight"] == "off" )
{
local lcdRightText = fe.add_text( my_config["lcdRightText"], blip*0.1584, blip*0.6208, blip*0.4, blip*0.04 );
lcdRightText.set_rgb( 59, 45, 3 );
lcdRightText.align = Align.Right;
lcdRightText.rotation = -6.6;
lcdRightText.font="digital-7 (italic)";  // free font (for personal use) - can be downloaded here: http://www.dafont.com/digital-7.font
}

local sYearManufacturer = fe.add_text( "[Year] [Manufacturer]", blip*0.1536, blip*0.5835, blip*0.48, blip*0.03 )
sYearManufacturer.set_rgb( 120, 120, 120 );
sYearManufacturer.align = Align.Left;
sYearManufacturer.rotation = -5.9;
sYearManufacturer.font="digital-7 (italic)";

local sTitle = fe.add_text( "[DisplayName] [ListEntry]/[ListSize] - [Title]", blip*0.005, blip*0.95, blip*0.9, blip*0.03 )
sTitle.set_rgb( 255, 255, 255 );
sTitle.align = Align.Left;
sTitle.font="digital-7 (italic)";

//LCD display text --------------------------------------------------------- END

 







// SpinWheel -------------------------- START - this part is slightly modified code from omegaman's ROBOSPIN theme

 
fe.load_module( "conveyor" );
local wheel_x = [ flx*0.87, flx*0.79, flx*0.765, flx*0.745, flx*0.73, flx*0.72, flx*0.67, flx*0.72, flx*0.73, flx*0.745, flx*0.765, flx*0.79, ]; 
local wheel_y = [ -fly*0.22, -fly*0.105, fly*0.0, fly*0.105, fly*0.215, fly*0.325, fly*0.436, fly*0.61, fly*0.72 fly*0.83, fly*0.935, fly*0.99, ];
local wheel_w = [ flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.28, flw*0.18, flw*0.18, flw*0.18, flw*0.18, flw*0.18, ];
local wheel_a = [  80,  80,  80,  80,  80,  80, 255,  80,  80,  80,  80,  80, ];
local wheel_h = [  flw*0.07,  flw*0.07,  flw*0.07,  flw*0.08,  flw*0.08,  flw*0.08, flw*0.11,  flw*0.07,  flw*0.07,  flw*0.07,  flw*0.07,  flw*0.07, ];
//local wheel_r = [  31,  26,  21,  16,  11,   6,   0, -11, -16, -21, -26, -31, ];
local wheel_r = [  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30, ];
local num_arts = Setting("aspectDepend", "wheelNumElements");  // number of elements in wheel - depending on screen aspect ratio




class WheelEntry extends ConveyorSlot
{
	constructor()
	{
		base.constructor( ::fe.add_artwork( my_config["spinwheelArt"] ) );
    preserve_aspect_ratio = true;
    video_flags=Vid.ImagesOnly; // added just in case if you have video marquees - like I do :)
	}

	function on_progress( progress, var )
	{
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		
		slot++;

		if ( slot < 0 ) slot=0;
		if ( slot >=10 ) slot=10;

		m_obj.x = wheel_x[slot] + p * ( wheel_x[slot+1] - wheel_x[slot] );
		m_obj.y = wheel_y[slot] + p * ( wheel_y[slot+1] - wheel_y[slot] );
		m_obj.width = wheel_w[slot] + p * ( wheel_w[slot+1] - wheel_w[slot] );
		m_obj.height = wheel_h[slot] + p * ( wheel_h[slot+1] - wheel_h[slot] );
		m_obj.rotation = wheel_r[slot] + p * ( wheel_r[slot+1] - wheel_r[slot] );
		m_obj.alpha = wheel_a[slot] + p * ( wheel_a[slot+1] - wheel_a[slot] );
	}
};

local wheel_entries = [];
for ( local i=0; i<num_arts/2; i++ )
	wheel_entries.push( WheelEntry() );

local remaining = num_arts - wheel_entries.len();

// we do it this way so that the last wheelentry created is the middle one showing the current
// selection (putting it at the top of the draw order)

for ( local i=0; i<remaining; i++ )
	wheel_entries.insert( num_arts/2, WheelEntry() );

local conveyor = Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try { conveyor.transition_ms = my_config["transition_ms"].tointeger(); } catch ( e ) { }