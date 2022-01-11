// user config menu ===================================================
class UserConfig {
  </
    label="Silent videos snaps",
    help="yes = sound disabled, no = sound enabled",
    options="yes,no",
    order=1
  /> mute_videoSnaps="no";
  </
    label="CRT screen content",
    help="video = video snap, screenshot = game screenshot",
    options="video, screenshot",
    order=2
  /> tvScreenType="video";
  </
    label="spinwheel artwork",
    help="marquee or wheel",
    options="marquee,wheel",
    order=3
  /> spinwheelArt="wheel";
  </
    label="speenwheel transition time",
    help="Time in milliseconds for wheel spin",
    order=4
  /> transition_ms="80";
  </
    label="Enable wheel pulse",
    help="Pulse current wheel logo",
    options="No,Once,Loop",
    order=5
  /> wheel_pulse="Once";
  </
    label="Enable load animations",
    help="Enable animations when system loads", 
		options="Yes,No",
    order=6
  /> enable_ini_anim="Yes";
	</
    label="Startup animation transition time", 
		help="Animated transition time in milliseconds", 
		options="600, 800, 1000, 1200, 1400, 1600, 1800, 2000",
		order=7
  /> ini_anim_trans_ms="1000";
  </
    label="Enable 3D Boxes art", 
		help="Enable 3D Boxes at", 
		options="Yes,No",
		order=8
  /> enable_3d_boxes="No";
}
// ====================================================================

// define main variables ==============================================
local my_config = fe.get_config();
fe.load_module("animate");
fe.load_module("fade");
local blip = fe.layout.height;
local flx = fe.layout.width + 120.0;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
fe.layout.width = 1920;
fe.layout.height = 1080;
local settings = {
  res_x = 1920,
  res_y = 1080,
  snap_skewX = 0.0,
  snap_skewY = 7.0,
  snap_pinchX = 51.0,
  snap_pinchY = 35.0,
  snap_rotation = -3.1,
  wheelNumElements = 8,
  x = blip*0.115,
  y = blip*0.115,
  w = blip*0.79,
  h = blip*0.585
}
fe.layout.width = settings["res_x"];
fe.layout.height = settings["res_y"];
local ini_anim_time;
try {
  ini_anim_time = my_config["ini_anim_trans_ms"].tointeger();
} catch ( e ) { }
// ====================================================================

// background image ===================================================
local bg = fe.add_image( "background.png", 0, 0, flw, flh );
bg.preserve_aspect_ratio = true;
if (my_config["enable_ini_anim"] == "Yes") {
  local move_bg_y = {
    when = Transition.StartLayout,
    property = "y",
    start = flh * -1.0,
    end = 0.0,
    tween = "cubic",
    time = 700.0
  }
	animation.add(PropertyAnimation(bg, move_bg_y));
  local alpha_bg = {
    when = Transition.StartLayout,
    property = "alpha",
    start = 0,
    end = 255,
    tween = "cubic",
    time = 3000,
  }
	animation.add(PropertyAnimation(bg, alpha_bg));
}
// ====================================================================

// desk image =========================================================
local desk = fe.add_image("desk.png", 0, 0, flw, flh);
desk.preserve_aspect_ratio = true;
// ====================================================================

// mute audio variable ================================================
if ( my_config["mute_videoSnaps"] == "yes") {
  ::videoSound <- Vid.NoAudio;
}
if ( my_config["mute_videoSnaps"] == "no") {
  ::videoSound <- Vid.Default;
}
// ====================================================================

// static tv effect on snap change (or if no snap available) ==========
local tvStatic = fe.add_image(
  "static.jpg",
  settings["x"],
  settings["y"],
  settings["w"],
  settings["h"]
);
tvStatic.skew_x = settings["snap_skewX"];
tvStatic.skew_y = settings["snap_skewY"];
tvStatic.pinch_x = settings["snap_pinchX"];
tvStatic.pinch_y = settings["snap_pinchY"];
tvStatic.rotation = settings["snap_rotation"];
// ====================================================================

// snap (video or snap) on tv screen ==================================
local tvScreen = fe.add_artwork(
  "snap",
  settings["x"],
  settings["y"],
  settings["w"],
  settings["h"]
);
tvScreen.skew_x = settings["snap_skewX"];
tvScreen.skew_y = settings["snap_skewY"];
tvScreen.pinch_x = settings["snap_pinchX"];
tvScreen.pinch_y = settings["snap_pinchY"];
tvScreen.rotation = settings["snap_rotation"];
tvScreen.trigger = Transition.EndNavigation;
tvScreen.preserve_aspect_ratio = false;
tvScreen.video_flags = videoSound;
if ( my_config["tvScreenType"] == "screenshot" ) {
  tvScreen.video_flags=Vid.ImagesOnly;
}
local sh = fe.add_shader(Shader.Fragment, "bloom_shader.frag");
sh.set_texture_param("bgl_RenderedTexture");
tvScreen.shader = sh;
// ====================================================================

// tv overlay image ===================================================
local tv = fe.add_image( "tv_set.png", 0, 0, flw, flh);
tv.preserve_aspect_ratio = true;
// ====================================================================

// LCD display text on CRT body =======================================
local sTitle = fe.add_text(
  "[Title]",
  blip * 0.0750,
  blip * 0.0563,
  blip * 0.7300,
  blip * 0.0300
);
sTitle.set_rgb( 63, 126, 195 );
sTitle.align = Align.Left;
sTitle.rotation = -0.1;
sTitle.font="digital-7 (italic)";

local lcdLeftText = fe.add_text(
  "PLAYED: " + "[PlayedCount]",
  blip * 0.630,
  blip * 0.056,
  blip * 0.300,
  blip * 0.030
);
lcdLeftText.set_rgb( 43, 106, 175 );
lcdLeftText.align = Align.Right;
lcdLeftText.rotation = -0.2;
lcdLeftText.font="digital-7 (italic)";
// ====================================================================

// LCD display overlay ================================================
local sLCDOverlay = fe.add_image(
  "tv_set_lcd_overlay.png",
  0,
  0,
  flw,
  flh
);
sLCDOverlay.preserve_aspect_ratio = true;
// ====================================================================

// Machine image ======================================================
local machine = fe.add_image("machines/[DisplayName].png", 0, 0, flw, flh);
machine.preserve_aspect_ratio = true;
if (my_config["enable_ini_anim"] == "Yes") {
  local move_machine_y = {
    when = Transition.ToNewList,
    property = "y",
    start = flw * 0.33,
    end = 0.0,
    tween = "cubic",
    time = 900.0
  }
	animation.add(PropertyAnimation(machine, move_machine_y));
}
// ====================================================================

// 3D Box =============================================================
if (my_config["enable_3d_boxes"] == "Yes") {
  local box_start_x = flw * 1.5;
  local box_dest_x = flw * 0.42;
  local flyer = fe.add_artwork(
    "flyer", flw * 1.5, flh * 0.12, flw * 0.45, flh * 0.45
  );
  flyer.trigger = Transition.EndNavigation;
  flyer.preserve_aspect_ratio = true;

  if (my_config["enable_ini_anim"] == "Yes") {
    local move_box_x = {
      when = Transition.StartLayout,
      property = "x",
      start = box_start_x,
      end = box_dest_x,
      tween = "cubic",
      time = 900,
      delay = 300
    }
    animation.add(PropertyAnimation(flyer, move_box_x));
  }

  local transition1 = {
    when = Transition.ToNewSelection,
    property = "x",
    start = box_start_x,
    end = box_dest_x,
    tween = "cubic",
    time = 1200
  }
  animation.add(PropertyAnimation(flyer, transition1));
}
// ====================================================================

// OSD complete game info =============================================
local sTitle = fe.add_text(
  "[DisplayName] [Name] [ListEntry]/[ListSize]",
  blip * 0.005,
  blip * 0.950,
  blip * 0.900,
  blip * 0.030
);
sTitle.set_rgb( 255, 255, 255 );
sTitle.align = Align.Left;
sTitle.font="digital-7 (italic)";
// ====================================================================

// SpinWheel ==========================================================
fe.load_module( "conveyor" );
local wheel_x = [
  flx * 0.870,
  flx * 0.790,
  flx * 0.765,
  flx * 0.745,
  flx * 0.730,
  flx * 0.720,
  flx * 0.670,
  flx * 0.720,
  flx * 0.730,
  flx * 0.745,
  flx * 0.765,
  flx * 0.790,
];
local wheel_y = [
  fly * 0.220 * -1.0,
  fly * 0.105 * -1.0,
  fly * 0.000,
  fly * 0.105,
  fly * 0.215,
  fly * 0.325,
  fly * 0.436,
  fly * 0.610,
  fly * 0.720,
  fly * 0.830,
  fly * 0.935,
  fly * 0.990,
];
local wheel_w = [
  flw*0.18,
  flw*0.18,
  flw*0.18,
  flw*0.18,
  flw*0.18,
  flw*0.18,
  flw*0.28,
  flw*0.18,
  flw*0.18,
  flw*0.18,
  flw*0.18,
  flw*0.18,
];
local wheel_a = [
  20, 30, 40, 50, 60, 70, 255, 70, 60, 50, 40, 30,
];
local wheel_h = [
  flw*0.07,
  flw*0.07,
  flw*0.07,
  flw*0.08,
  flw*0.08,
  flw*0.08,
  flw*0.11,
  flw*0.07,
  flw*0.07,
  flw*0.07,
  flw*0.07,
  flw*0.07,
];
local wheel_r = [
  30,  25,  20,  15,  10,   5,   0, -10, -15, -20, -25, -30,
];
local num_arts = settings["wheelNumElements"];

class WheelEntry extends ConveyorSlot {
	constructor() {
		base.constructor(
      ::fe.add_artwork(my_config["spinwheelArt"])
    );
    preserve_aspect_ratio = true;
    video_flags=Vid.ImagesOnly; // in case you have video marquees
	}

	function on_progress( progress, var ) {
		local p = progress / 0.1;
		local slot = p.tointeger();
		p -= slot;
		slot++;
		if ( slot < 0 ) { slot=0; }
		if ( slot >=10 ) { slot=10; }
		m_obj.x = wheel_x[slot] + p * (wheel_x[slot+1] - wheel_x[slot]);
		m_obj.y = wheel_y[slot] + p * (wheel_y[slot+1] - wheel_y[slot]);
		m_obj.width = wheel_w[slot] + p * (wheel_w[slot+1] - wheel_w[slot]);
		m_obj.height = wheel_h[slot] + p * (wheel_h[slot+1] - wheel_h[slot]);
		m_obj.rotation = wheel_r[slot] + p * (wheel_r[slot+1] - wheel_r[slot]);
		m_obj.alpha = wheel_a[slot] + p * (wheel_a[slot+1] - wheel_a[slot]);
	}
};

local wheel_entries = [];
for (local i = 0; i < num_arts / 2; i++) {
  wheel_entries.push(WheelEntry());
}

local remaining = num_arts - wheel_entries.len();
for (local i = 0; i < remaining; i++) {
  wheel_entries.insert(num_arts / 2, WheelEntry());
}

local conveyor = Conveyor();
conveyor.set_slots( wheel_entries );
conveyor.transition_ms = 50;
try {
  conveyor.transition_ms = my_config["transition_ms"].tointeger();
} catch ( e ) {}

// Pulse wheel logo method ============================================
if ( my_config["wheel_pulse"] != "No" ) {
  local _time = 1200;
  local _partially = 30;
	local _loop = false;
	local art = wheel_entries[num_arts/2].m_obj;
	local art_pulse = fe.add_artwork(
    "wheel", art.x,art.y,art.width,art.height
  );
  if (my_config["wheel_pulse"] == "Loop") { _loop = true; }
	art.zorder = 1
  art_pulse.preserve_aspect_ratio=true;

	local alpha_cfg = {
    when = Transition.StartLayout,
    property = "alpha",
    start = 150,
    end = 0,
    time = _time,
    loop = _loop
  }
	animation.add(PropertyAnimation(art_pulse, alpha_cfg));

	local art_scale = {
    when = Transition.StartLayout,
    property = "scale",
    start = 1.0,
    end = 1.2,
    time = _time - 1,
    loop = _loop
  }
	animation.add(PropertyAnimation(art_pulse, art_scale));

	function pulse_transition(ttype, var, ttime) {
		if (ttype == Transition.ToNewSelection) {
			if (alpha_cfg.loop == true) {
				alpha_cfg.start = 0;
				alpha_cfg.loop = false;
				art_scale.loop = false;
			}
			art_pulse.alpha = 0;
		}
		return false;
	}

	fe.add_transition_callback("pulse_transition");

	local alpha_cfg2 = {
    when = Transition.ToNewSelection,
    property = "alpha",
    start = 150,
    end = 0,
    time = _time,
    loop = _loop
  }
	animation.add(PropertyAnimation(art_pulse, alpha_cfg2));

	local art_scale2 = {
    when = Transition.ToNewSelection,
    property = "scale",
    start = 1.0,
    end = 1.2,
    time = _time - 1,
    loop = _loop
  }
	animation.add(PropertyAnimation(art_pulse, art_scale2));

	function stop_pulse(ttime) {
		if (
      conveyor.m_objs[num_arts / 2].m_obj.alpha == 0 ||
      conveyor.m_objs[num_arts / 2].m_obj.alpha == _partially
    ) {
			alpha_cfg.loop = false;
			alpha_cfg2.loop = false;
		} else {
			alpha_cfg.loop = true;
			alpha_cfg2.loop = true;
			if (my_config["wheel_pulse"] == "Once") {
				alpha_cfg.loop = false;
				alpha_cfg2.loop = false;
			}
		}
	}

	fe.add_ticks_callback("stop_pulse");
}
// ====================================================================
