# (c) pinto 2018

# properties
var master_power_prop = props.globals.getNode("controls/electric/battery-switch"); # bool
var speed_prop = props.globals.getNode("velocities/airspeed-kt");
var pitch_prop = props.globals.getNode("orientation/pitch-deg");
var heading_prop = props.globals.getNode("orientation/heading-deg");
var roll_prop = props.globals.getNode("orientation/roll-deg");

# function ref
var cur_main_func = nil;
var cur_init_func = nil;
var cur_end_func = nil;

var MFD_DISPLAY = {

    canvas_settings: {
        "name": "MFD_DISPLAY",   # The name is optional but allow for easier identification
        "size": [1024, 1024], # Size of the underlying texture (should be a power of 2, required) [Resolution]
        "view": [1024, 1024],  # Virtual resolution (Defines the coordinate system of the canvas [Dimensions]
        # which will be stretched the size of the texture, required)
        "mipmapping": 1       # Enable mipmapping (optional)
    },
    new: func(placement) {
        var m = {
        parents: [MFD_DISPLAY],
        mfd: canvas.new(MFD_DISPLAY.canvas_settings)
        };

        m.mfd.addPlacement(placement);
        m.mfd.setColorBackground(0,0,0,0);
        m.mfd_labels = m.mfd.createGroup();

        m.lbl1 = m.mfd_labels.createChild("text", "lbl1")
            .setTranslation(6, 160)
            .setAlignment("left-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl2 = m.mfd_labels.createChild("text", "lbl2")
            .setTranslation(6, 338)
            .setAlignment("left-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl3 = m.mfd_labels.createChild("text", "lbl3")
            .setTranslation(6, 516)
            .setAlignment("left-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl4 = m.mfd_labels.createChild("text", "lbl4")
            .setTranslation(6, 694)
            .setAlignment("left-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl5 = m.mfd_labels.createChild("text", "lbl5")
            .setTranslation(6, 872)
            .setAlignment("left-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);

        m.lbl6 = m.mfd_labels.createChild("text", "lbl6")
            .setTranslation(192, 1018)
            .setAlignment("center-bottom")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1)
            .setColorFill(0,0,0);
        m.lbl7 = m.mfd_labels.createChild("text", "lbl7")
            .setTranslation(352, 1018)
            .setAlignment("center-bottom")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1)
            .setColorFill(0,0,0);
        m.lbl8 = m.mfd_labels.createChild("text", "lbl8")
            .setTranslation(512, 1018)
            .setAlignment("center-bottom")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1)
            .setColorFill(0,0,0);
        m.lbl9 = m.mfd_labels.createChild("text", "lbl9")
            .setTranslation(672, 1018)
            .setAlignment("center-bottom")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1)
            .setColorFill(0,0,0);
        m.lbl10 = m.mfd_labels.createChild("text", "lbl10")
            .setTranslation(832, 1018)
            .setAlignment("center-bottom")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1)
            .setColorFill(0,0,0);

        m.lbl15 = m.mfd_labels.createChild("text", "lbl15")
            .setTranslation(1018, 160)
            .setAlignment("right-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl14 = m.mfd_labels.createChild("text", "lbl14")
            .setTranslation(1018, 338)
            .setAlignment("right-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl13 = m.mfd_labels.createChild("text", "lbl13")
            .setTranslation(1018, 516)
            .setAlignment("right-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl12 = m.mfd_labels.createChild("text", "lbl12")
            .setTranslation(1018, 694)
            .setAlignment("right-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl11 = m.mfd_labels.createChild("text", "lbl11")
            .setTranslation(1018, 872)
            .setAlignment("right-center")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);

        m.lbl20 = m.mfd_labels.createChild("text", "lbl20")
            .setTranslation(192, 6)
            .setAlignment("center-top")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl19 = m.mfd_labels.createChild("text", "lbl19")
            .setTranslation(352, 6)
            .setAlignment("center-top")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl18 = m.mfd_labels.createChild("text", "lbl18")
            .setTranslation(512, 6)
            .setAlignment("center-top")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl17 = m.mfd_labels.createChild("text", "lbl17")
            .setTranslation(672, 6)
            .setAlignment("center-top")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);
        m.lbl16 = m.mfd_labels.createChild("text", "lbl16")
            .setTranslation(832, 6)
            .setAlignment("center-top")
            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
            .setFontSize(26, 1.0)
            .setColor(1,1,1);

        m.mfd_labels.set("z-index", 100);

        # for status screen
        m.status_texts = nil;

        # for the fuel screen
        m.fuel_group = nil;

        m.vsi_group = nil;

        # for map screen
        m.airports = [];
        m.map_airport_layer = m.mfd.createGroup("airports");
        m.airport_arch = {
            icao: "",
            lat: 0,
            lon: 0,
            alt: 0,
            symbol: m.map_airport_layer.createChild("path")
                .setColor(1,1,1)
                .setStrokeLineWidth(3)
                .move(-26,-26)
                .line(19,19)
                .move(-19,33)
                .line(19,-19)
                .move(33,19)
                .line(-19,-19)
                .move(19,-33)
                .line(-19,19)
                .hide()
        };

        # for SAR screen
        m.sar_max_dist = 50000; # meters
        m.sar_min_dist = 0;
        m.max_update_time = 0.0075;
        m.sar_tests_per_loop = 40;
        m.sar_index_x = 0;
        m.sar_index_y = 0;
        m.sar_write_index_x = 0;
        m.sar_write_index_y = 0;
        m.sar_border_size = 75;
        m.sar_fov_x = 20;
        m.sar_res_x = 40;
        m.sar_fov_y = 20;
        m.sar_res_y = 40;
        m.sar_pixel_groups = 8;
        m.sar_slew_horiz = 0;
        m.sar_slew_vert = 0;
        m.sar_gain = 1;
        m.pause_draw = 1;

        m.sar_geo = geo.Coord.new();
        m.sar_zoom = 1;
        m.sar_bearing = 0;
        m.sar_pitch = 0;
        m.sar_pixels = nil;
        m.max_fov_x = m.sar_fov_x;
        m.max_fov_y = m.sar_fov_y;

        me.sar_loops = 0;

        return m;
    },

    update_labels: func() {
        me.lbl1.setText(button_array[0].label);
        me.lbl2.setText(button_array[1].label);
        me.lbl3.setText(button_array[2].label);
        me.lbl4.setText(button_array[3].label);
        me.lbl5.setText(button_array[4].label);
        me.lbl6.setText(button_array[5].label);
        me.lbl7.setText(button_array[6].label);
        me.lbl8.setText(button_array[7].label);
        me.lbl9.setText(button_array[8].label);
        me.lbl10.setText(button_array[9].label);
        me.lbl11.setText(button_array[10].label);
        me.lbl12.setText(button_array[11].label);
        me.lbl13.setText(button_array[12].label);
        me.lbl14.setText(button_array[13].label);
        me.lbl15.setText(button_array[14].label);
        me.lbl16.setText(button_array[15].label);
        me.lbl17.setText(button_array[16].label);
        me.lbl18.setText(button_array[17].label);
        me.lbl19.setText(button_array[18].label);
        me.lbl20.setText(button_array[19].label);
    },

    # STATUS SCREEN

    screen_status_init: func() {
        #print("screen status init");
        reset_button_array();
        button_array[0] = button_sar;
        button_array[1] = button_fuel;
        button_array[2] = button_vsi;
        me.update_labels();
        if (me.status_texts == nil) {
            me.status_texts = me.mfd.createGroup();
            me.status_texts.createChild("text", "speed")
                .setTranslation(100, 100)
                .setAlignment("left-center")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.status_texts.createChild("text", "altitude")
                .setTranslation(100, 130)
                .setAlignment("left-center")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.status_texts.createChild("text", "heading")
                .setTranslation(100, 160)
                .setAlignment("left-center")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);

        }
        me.status_texts.show();
    },
    screen_status_rem: func() {
        #print("remming screen status?");
        if (me.status_texts != nil) {
            #print("remming screen status.");
            me.status_texts.hide();
        }
    },
    screen_status: func() {
        #print("screen status");
        me.status_texts.getElementById("speed").setText(sprintf("Speed..........%i kts",props.globals.getNode("velocities/airspeed-kt").getValue()));
        me.status_texts.getElementById("altitude").setText(sprintf("Altitude.......%i ft",props.globals.getNode("position/altitude-ft").getValue()));
        me.status_texts.getElementById("heading").setText(sprintf("Heading........%i",props.globals.getNode("orientation/heading-magnetic-deg").getValue()));
    },

    # TERRAIN RADAR IMAGING

    screen_sar_init: func() {
        #print("screen sar init");
        reset_button_array();
        button_array[0] = button_status;
        button_array[1] = button_sar_pause;
        button_array[17] = button_sar_dist_dec;
        button_array[18] = button_sar_dist_inc;
        button_array[16] = button_sar_zoom_out;
        button_array[15] = button_sar_zoom_in;
        button_array[14] = button_sar_slew_ctr;
        button_array[13] = button_sar_slew_left;
        button_array[12] = button_sar_slew_right;
        button_array[11] = button_sar_slew_up;
        button_array[10] = button_sar_slew_down;
        button_array[8] = button_sar_gain_inc;
        button_array[9] = button_sar_gain_dec;
        me.update_labels();
        if (me.sar_pixels == nil) {
            me.sar_pixel_path_array = [];
            me.sar_pixel_path_array_index = 1;

            for (var i = 1; i <= me.sar_pixel_groups; i = i + 1) {
                append(me.sar_pixel_path_array, me.mfd.createGroup());
            }

            me.sar_pixels = me.mfd.createGroup();
            me.sar_pixel_array = [];
            me.sar_pixel_x_size = (MFD_DISPLAY.canvas_settings["view"][0] - (me.sar_border_size * 2)) / me.sar_res_x;
            # print("m " ~ me.sar_pixel_x_size);
            me.sar_pixel_y_size = (MFD_DISPLAY.canvas_settings["view"][1] - (me.sar_border_size * 2)) / me.sar_res_y;
            for (i = 0; i < me.sar_res_x; i = i + 1) {
                append(me.sar_pixel_array,[]);
                for(j = 0; j < me.sar_res_y; j = j + 1) {
                    #print(i~j);
                    append(me.sar_pixel_array[i],
                        {
                            normval: 0,
                            distval: -1,
                            active:  0,
                            pixel: me.sar_pixel_path_array[me.sar_pixel_path_array_index - 1].createChild("path","pixel"~i~j).rect(
                                                                                                    (i * me.sar_pixel_x_size) + me.sar_border_size,
                                                                                                    (j * me.sar_pixel_y_size) + me.sar_border_size,
                                                                                                    me.sar_pixel_x_size,
                                                                                                    me.sar_pixel_y_size)
                        });
                    if (me.sar_pixel_path_array_index >= me.sar_pixel_groups) {
                        me.sar_pixel_path_array_index = 1;
                    } else {
                        me.sar_pixel_path_array_index = me.sar_pixel_path_array_index + 1;
                    }
                }
            }
            me.sar_pixels.setCenter(512,512);

            me.sar_labels = me.mfd.createGroup();
            # create backgrounds for the labels
            me.sar_labels.createChild("path","labelbg1")
                .rect(784,42,127,110) # + 22
                .setColorFill(0,0,0);
            # create the labels
            #786.64
            me.sar_labels.createChild("text", "sar_dist_display")
                .setTranslation(786,44)
                .setAlignment("left-top")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.sar_labels.createChild("text", "sar_horiz_slew_display")
                .setTranslation(786,64)
                .setAlignment("left-top")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.sar_labels.createChild("text", "sar_vert_slew_display")
                .setTranslation(786,84)
                .setAlignment("left-top")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.sar_labels.createChild("text", "sar_zoom_display")
                .setTranslation(786,104)
                .setAlignment("left-top")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.sar_labels.createChild("text", "sar_gain_display")
                .setTranslation(786,124)
                .setAlignment("left-top")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.sar_labels.createChild("text", "sar_loop_display")
                .setTranslation(512,480)
                .setAlignment("center-center")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);
            me.sar_labels.createChild("text", "sar_pause_display")
                .setTranslation(512,510)
                .setAlignment("center-center")
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setFontSize(26, 1.0)
                .setColor(1,1,1);

            me.sar_labels.createChild("path", "sar_center_marker_white")
                .setColor(1,1,1)
                .setStrokeLineWidth(3)
                .move(-26,-26)
                .line(19,19)
                .move(-19,33)
                .line(19,-19)
                .move(33,19)
                .line(-19,-19)
                .move(19,-33)
                .line(-19,19);
            me.sar_labels.createChild("path", "sar_center_marker_black")
                .setColor(0,0,0)
                .setStrokeLineWidth(3)
                .move(-26,-26)
                .line(19,19)
                .move(-19,33)
                .line(19,-19)
                .move(33,19)
                .line(-19,-19)
                .move(19,-33)
                .line(-19,19);

            me.sar_labels.set("z-index", 99);
            me.sar_labels.getElementById("sar_center_marker_white").setTranslation(512,514);
            me.sar_labels.getElementById("sar_center_marker_black").setTranslation(512,510);
        }
        me.sar_labels.show();
        for (i = 0; i < size(me.sar_pixel_path_array); i = i + 1) {
            me.sar_pixel_path_array[i].show();
        }
    },

    screen_sar_rem: func() {
        #print('hiding pixels?');
        if (me.sar_pixels != nil) {
            #print('hiding pixels.');
            for (i = 0; i < size(me.sar_pixel_path_array); i = i + 1) {
                me.sar_pixel_path_array[i].hide();
            }
            me.sar_labels.hide();
        }
    },

    screen_sar: func() {
        me.sar_labels.getElementById("sar_dist_display").setText("DIST: " ~ (me.sar_max_dist/1000));
        me.sar_labels.getElementById("sar_horiz_slew_display").setText("SLW>: " ~ me.sar_slew_horiz);
        me.sar_labels.getElementById("sar_vert_slew_display").setText("SLWΛ: " ~ me.sar_slew_vert);
        me.sar_labels.getElementById("sar_zoom_display").setText("ZOOM: x" ~ me.sar_zoom);
        me.sar_labels.getElementById("sar_gain_display").setText("GAIN: " ~ me.sar_gain);
        #me.sar_labels.getElementById("sar_loop_display").setText("# Loops: " ~ me.sar_loops);

        #if (me.pause_draw == 0) {
        #    me.sar_labels.getElementById("sar_pause_display").setText("** PAUSED **");
        #} else {
        #    me.sar_labels.getElementById("sar_pause_display").setText("");
        #}

        #print('screensar');
        me.ang_px_x = me.sar_fov_x / me.sar_res_x;
        me.ang_px_y = me.sar_fov_y / me.sar_res_y;
        me.fov_x = me.sar_fov_x / 2;
        me.fov_y = me.sar_fov_y / 2;

        me.sar_min_dist = (me.sar_gain - 1) * 2500;

        #me.screen_sar_get_spread();

        if (me.sar_index_x == 0 and me.sar_index_y == 0) {
            #print('rsetting');
            me.sar_pitch = pitch_prop.getValue();
            me.sar_heading = heading_prop.getValue();
            me.sar_geo.set_latlon(geo.aircraft_position().lat(), geo.aircraft_position().lon(), geo.aircraft_position().alt());
        }

        me.testPos = geo.Coord.new();
        #print("loop");

        me.start_time = systime();
        me.sar_loops = 0;
        while (systime() - me.start_time < me.max_update_time) {
            if (me.pause_draw == 0) {return;}
            me.sar_loops = me.sar_loops + 1;
            if (me.sar_index_x == 0 and me.sar_index_y == 0) {
                #print('rsetting');
                me.sar_pitch = pitch_prop.getValue();
                me.sar_heading = heading_prop.getValue();
                me.sar_geo.set_latlon(geo.aircraft_position().lat(), geo.aircraft_position().lon(), geo.aircraft_position().alt());
            }
        #for (var i = 0; i < me.sar_tests_per_loop; i = i + 1) {
            #heading = (my_heading + sar_bearing) - (sar_fov_x / 2) + (sar_index_x * ang_px_x)
            #pitch   = (my_pitch + sar_pitch)     - (sar_fov_y / 2) + (sar_index_y * ang_px_y)
            me.heading = (me.sar_heading + me.sar_slew_horiz) - me.fov_x + (me.sar_index_x * me.ang_px_x);
            me.pitch = (me.sar_pitch + me.sar_slew_vert) + me.fov_y - (me.sar_index_y * me.ang_px_y);
            me.testPos.set_latlon(me.sar_geo.lat(), me.sar_geo.lon(), me.sar_geo.alt()); #just setting testPos to sar_geo took too long.
            me.testPos.apply_course_distance(me.heading, me.sar_max_dist);
            me.testPos.set_alt((math.tan(me.pitch * D2R) * me.sar_max_dist) + me.sar_geo.alt());
            #if( me.sar_index_x == 0 and me.sar_index_y == 0) {
            #    print("mypos: " ~ me.myPos.alt());
            #    print("testpos: " ~ me.testPos.alt());
            #}
            me.xyz = {"x":me.sar_geo.x(),                "y":me.sar_geo.y(),                "z":me.sar_geo.z()};
            me.dir = {"x":me.testPos.x()-me.sar_geo.x(), "y":me.testPos.y()-me.sar_geo.y(), "z":me.testPos.z()-me.sar_geo.z()};
            var intersec = get_cart_ground_intersection(me.xyz, me.dir);
            if (intersec == nil) {
                if (me.sar_pixel_array[me.sar_index_x][me.sar_index_y].distval != me.sar_max_dist) {
                    me.sar_pixel_array[me.sar_index_x][me.sar_index_y].distval = me.sar_max_dist;
                    me.sar_pixel_array[me.sar_index_x][me.sar_index_y].pixel.setColor(0, 0, 0);
                    me.sar_pixel_array[me.sar_index_x][me.sar_index_y].pixel.setColorFill(0, 0, 0);
                }
            } else {
                me.testPos.set_latlon(intersec.lat, intersec.lon, intersec.elevation);
                # print("x " ~ me.sar_index_x);
                # print("y " ~ me.sar_index_y);
                me.distval = me.sar_geo.direct_distance_to(me.testPos);
                if (me.distval == me.sar_pixel_array[me.sar_index_x][me.sar_index_y].distval ) { continue; }
                if (me.distval < me.sar_min_dist) {
                    me.sar_pixel_array[me.sar_index_x][me.sar_index_y].distval = 0;
                    me.sar_pixel_array[me.sar_index_x][me.sar_index_y].pixel.setColor(0, 0, 0);
                    me.sar_pixel_array[me.sar_index_x][me.sar_index_y].pixel.setColorFill(0, 0, 0);
                }
                me.sar_pixel_array[me.sar_index_x][me.sar_index_y].distval = me.distval;
                me.color = (me.sar_max_dist - me.distval) / (me.sar_max_dist - me.sar_min_dist);

                me.sar_pixel_array[me.sar_index_x][me.sar_index_y].pixel.setColor(me.color, me.color, me.color);
                me.sar_pixel_array[me.sar_index_x][me.sar_index_y].pixel.setColorFill(me.color, me.color, me.color);
            }

            if (me.sar_index_x >= me.sar_res_x - 2) {
                if (me.sar_index_y >= me.sar_res_y - 1) {
                    #print("1f " ~ me.sar_index_x);
                    #print("mod " ~ math.mod(me.sar_index_x, 2));
                    me.sar_index_x = math.mod(me.sar_index_x, 2) == 0 ? 1 : 0;
                    #print(me.sar_index_x);
                    me.sar_index_y = 0;
                } else {
                    #print("inc y");
                    me.sar_index_y = me.sar_index_y + 1;
                    me.sar_index_x = math.mod(me.sar_index_x, 2) == 0 ? 0 : 1;
                }
            } else {
                #print("inc x");
                me.sar_index_x = me.sar_index_x + 2;
            }
        }
        #print("we did " ~ me.sar_loops ~ " loops.");
    },

    screen_sar_inc_dist: func() {
        if (me.sar_max_dist < 100000) {
            me.sar_max_dist = me.sar_max_dist + 10000; # meters
        }
    },
    screen_sar_dec_dist: func() {
        if (me.sar_max_dist > 10000) {
            me.sar_max_dist = me.sar_max_dist - 10000; # meters
        }
    },
    screen_sar_slew_left: func() {
        if (me.sar_slew_horiz > -30) {
            me.sar_slew_horiz = me.sar_slew_horiz - 1;
        }
    },
    screen_sar_slew_right: func() {
        if (me.sar_slew_horiz < 30) {
            me.sar_slew_horiz = me.sar_slew_horiz + 1;
        }
    },
    screen_sar_slew_up: func() {
        if (me.sar_slew_vert < 30) {
            me.sar_slew_vert = me.sar_slew_vert + 1;
        }

    },
    screen_sar_slew_down: func() {
        if (me.sar_slew_vert > -30) {
            me.sar_slew_vert = me.sar_slew_vert - 1;
        }
    },
    screen_sar_slew_center: func() {
        me.sar_slew_horiz = 0;
        me.sar_slew_vert = 0;
    },
    screen_sar_zoom_in: func() {
        if (me.sar_zoom < 16) {
            me.sar_zoom = me.sar_zoom + 1;
            me.sar_fov_x = me.max_fov_x / me.sar_zoom;
            me.sar_fov_y = me.max_fov_y / me.sar_zoom;
        }
    },
    screen_sar_zoom_out: func() {
        if (me.sar_zoom > 1) {
            me.sar_zoom = me.sar_zoom - 1;
            me.sar_fov_x = me.max_fov_x / me.sar_zoom;
            me.sar_fov_y = me.max_fov_y / me.sar_zoom;
        }
    },
    screen_sar_gain_inc: func() {
        me.sar_gain = me.sar_gain + 1;
    },
    screen_sar_gain_dec: func() {
        if (me.sar_gain > 1) {
            me.sar_gain = me.sar_gain - 1;
        }
    },
    screen_sar_pause_draw: func() {
        me.pause_draw = (me.pause_draw - 1) * -1;
    },

    screen_testfunc: func() {
        return;
    },

    screen_fuel_init: func() {
        reset_button_array();
        button_array[0] = button_status;
        me.update_labels();
        # we need a simple diagram for the plane
        # we need lines connecting the tanks to an "Engine"
        # the active lines will be green
        # each tank will have text displaying fuel quantity

        # below, have stats such as
        # - current fuel burn rate
        # - remaining distance on that fuel tank
        # - total remaining distance (estimated + rounded)
        # - active tank
        # - combined fuel amount
        if (me.fuel_group == nil) {

            me.fuel_tank_left_prop = props.globals.getNode("/consumables/fuel/tank[0]/level-gal_us");
            me.fuel_tank_center_prop = props.globals.getNode("/consumables/fuel/tank[1]/level-gal_us");
            me.fuel_tank_right_prop = props.globals.getNode("/consumables/fuel/tank[2]/level-gal_us");
            me.fuel_consumption_prop = props.globals.getNode("/engines/engine/fuel-flow-gph");
            me.fuel_selector_prop = props.globals.getNode("/sim/model/fuelselector");
            me.fuel_total_prop = props.globals.getNode("consumables/fuel/total-fuel-gal_us");

            me.fuel_group = me.mfd.createGroup();
            me.fuel_group.createChild("path","silhouette")
                .move(92,-352)
                .line(-184,0)
                .line(0,125)
                .line(-310,0)
                .line(0,195)
                .line(305,0)
                .line(97,320)
                .line(97,-320)
                .line(305,0)
                .line(0,-195)
                .line(-310,0)
                .line(0,-125)
                .setStrokeLineWidth(2)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1)
                .setTranslation(512,512);

            me.fuel_group.createChild("path","fuelboxes")
                .rect(150,350,160,60)
                .rect(714,350,160,60)
                .rect(432,455,160,60)
                .rect(440,180,144,70)
                .setStrokeLineWidth(2)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1);

            me.fuel_group.createChild("path","fuellineleft")
                .moveTo(310,380)
                .lineTo(512,380)
                .setStrokeLineWidth(4)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1);

            me.fuel_group.createChild("path","fuellineright")
                .moveTo(714,380)
                .lineTo(512,380)
                .setStrokeLineWidth(4)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1);

            me.fuel_group.createChild("path","fuellinecenter")
                .moveTo(512,455)
                .lineTo(512,380)
                .setStrokeLineWidth(4)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1);

            me.fuel_group.createChild("path","fuellinefeed")
                .moveTo(512,250)
                .lineTo(512,380)
                .setStrokeLineWidth(4)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1);


            me.fuel_group.createChild("text","fuelinfoleft")
                .setAlignment("center-left")
                .setFontSize(50)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(155,400);

            me.fuel_group.createChild("text","fuelinforight")
                .setAlignment("center-left")
                .setFontSize(50)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(719,400);

            me.fuel_group.createChild("text","fuelinfocenter")
                .setAlignment("center-left")
                .setFontSize(50)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(437,500);

            me.fuel_group.createChild("text","fuelinfoengine")
                .setAlignment("center-left")
                .setFontSize(45)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(445,235);

            me.fuel_group.createChild("text","total_fuel")
                .setAlignment("center-left")
                .setFontSize(26)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(100,830);
            me.fuel_group.createChild("text","total_time_remaining")
                .setAlignment("center-left")
                .setFontSize(26)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(100,850);
            me.fuel_group.createChild("text","total_distance_remaining")
                .setAlignment("center-left")
                .setFontSize(26)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(100,870);
            me.fuel_group.createChild("text","tank_time_remaining")
                .setAlignment("center-left")
                .setFontSize(26)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(100,890);
            me.fuel_group.createChild("text","tank_distance_remaining")
                .setAlignment("center-left")
                .setFontSize(26)
                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                .setColor(1,1,1)
                .setTranslation(100,910);

        }

        me.fuel_group.getElementById("fuelinfoleft").setText(sprintf("%05.2f",me.fuel_tank_left_prop.getValue()));
        me.fuel_group.getElementById("fuelinforight").setText(sprintf("%05.2f",me.fuel_tank_right_prop.getValue()));
        me.fuel_group.getElementById("fuelinfocenter").setText(sprintf("%05.2f",me.fuel_tank_center_prop.getValue()));
        me.fuel_group.getElementById("fuelinfoengine").setText(sprintf("%05.2f",me.fuel_consumption_prop.getValue()));
        me.old_select = -1;
        me.line_feed_color = 0;

        me.fuel_group.show();
    },

    screen_fuel_rem: func() {
        if (me.fuel_group != nil) {
            me.fuel_group.hide();
        }
    },

    screen_fuel: func() {

        if (me.fuel_selector_prop.getValue() == 0) {
            me._fuelprop = me.fuel_tank_left_prop;
        } elsif (me.fuel_selector_prop.getValue() == 1) {
            me._fuelprop = me.fuel_tank_center_prop;
        } else {
            me._fuelprop = me.fuel_tank_right_prop;
        }
        me.fuel_group.getElementById("fuelinfoleft").setText(sprintf("%05.2f",me.fuel_tank_left_prop.getValue()));
        me.fuel_group.getElementById("fuelinfocenter").setText(sprintf("%05.2f",me.fuel_tank_center_prop.getValue()));
        me.fuel_group.getElementById("fuelinforight").setText(sprintf("%05.2f",me.fuel_tank_right_prop.getValue()));
        me.fuel_group.getElementById("fuelinfoengine").setText(sprintf("%05.2f",me.fuel_consumption_prop.getValue()));

        if (me.old_select != me.fuel_selector_prop.getValue()) {
            if (me.fuel_selector_prop.getValue() == 0) {
                me.fuel_group.getElementById("fuellineleft").setColor(0,1,0);
                me.fuel_group.getElementById("fuellinecenter").setColor(1,1,1);
                me.fuel_group.getElementById("fuellineright").setColor(1,1,1);

            } elsif (me.fuel_selector_prop.getValue() == 1) {
                me.fuel_group.getElementById("fuellineleft").setColor(1,1,1);
                me.fuel_group.getElementById("fuellinecenter").setColor(0,1,0);
                me.fuel_group.getElementById("fuellineright").setColor(1,1,1);
            } else {
                me.fuel_group.getElementById("fuellineleft").setColor(1,1,1);
                me.fuel_group.getElementById("fuellinecenter").setColor(1,1,1);
                me.fuel_group.getElementById("fuellineright").setColor(0,1,0);
            }
        }

        if (me.line_feed_color == 0 and me.fuel_consumption_prop.getValue() > 0) {
            me.fuel_group.getElementById("fuellinefeed").setColor(0,1,0);
            me.line_feed_color = 1;
        } elsif (me.line_feed_color == 1 and me.fuel_consumption_prop.getValue() <= 0) {
            me.line_feed_color = 0;
            me.fuel_group.getElementById("fuellinefeed").setColor(1,1,1);
        }

        # time remaining = total fuel / fuel flow
        # distance remaining = speed * time

        me.fuel_group.getElementById("total_fuel").setText(sprintf("Total fuel..........%05.1f gals",me.fuel_total_prop.getValue()));
        if (me.fuel_consumption_prop.getValue() != 0) {
            me._tr = me.fuel_total_prop.getValue() / me.fuel_consumption_prop.getValue();
        } else {
            me._tr = 9999;
        }
        me.fuel_group.getElementById("total_time_remaining").setText(sprintf("Time remaining......%05.1f hours",me._tr));
        me.fuel_group.getElementById("total_distance_remaining").setText(sprintf("Dist remaining......%05.1f NM",speed_prop.getValue() * me._tr));
        if (me.fuel_consumption_prop.getValue() != 0) {
            me._tr = me._fuelprop.getValue() / me.fuel_consumption_prop.getValue();
        } else {
            me._tr = 9999;
        }
        me.fuel_group.getElementById("tank_time_remaining").setText(sprintf("Time left in tank...%05.1f hours",me._tr));
        me.fuel_group.getElementById("tank_distance_remaining").setText(sprintf("Dist left in tank...%05.1f NM",speed_prop.getValue() * me._tr));


        me.old_select = me.fuel_selector_prop.getValue();
    },

    screen_vsi_init: func() {
        #reset_button_array();
        test_button_array();
        button_array[0] = button_status;
        me.update_labels();
        # todo:
        # sideslip
        # compass
        # print out roll somewhere
        if (me.vsi_group == nil) {

            me.upper_limit = 180;
            me.lower_limit = 580;
            me.edge_dist = 130;
            me.far_edge_dist = 250;
            me.vert_center = ((me.lower_limit-me.upper_limit)/2)+me.upper_limit;

            me.vsi_group = me.mfd.createGroup();
            me.vsi_group.createChild("path","outlines")
                .moveTo(me.edge_dist,me.upper_limit)
                .lineTo(me.edge_dist,me.lower_limit)
                .lineTo(me.far_edge_dist,me.lower_limit)
                .lineTo(me.far_edge_dist,me.upper_limit)
                .lineTo(me.edge_dist,me.upper_limit)
                .moveTo(1024 - me.edge_dist,me.upper_limit)
                .lineTo(1024 - me.edge_dist,me.lower_limit)
                .lineTo(1024 - me.far_edge_dist,me.lower_limit)
                .lineTo(1024 - me.far_edge_dist,me.upper_limit)
                .lineTo(1024 - me.edge_dist,me.upper_limit)
                .setStrokeLineWidth(4)
                .setStrokeLineJoin("bevel")
                .setColor(1,1,1);
                
            ################
            # speedtape stuff
            ################
            
            me.speed_tape_visible = 60; #how many knots to show at one time
            me.speed_tape_pixel_per_knot = (me.lower_limit - me.upper_limit) / me.speed_tape_visible;
            me.speed_tape_text = [];
            me.speedbars_major = [];
            me.speedbars_minor = [];
            for(var i = 1; i <= math.ceil(me.speed_tape_visible/10); i = i + 1){
                append(me.speedbars_major, me.vsi_group.createChild("path","speedbar" ~ i)
                                            .line(-50,0)
                                            .setStrokeLineWidth(4)
                                            .setColor(1,1,1));
                append(me.speed_tape_text, me.vsi_group.createChild("text","tape_read" ~ i)
                                            .setAlignment("right-center")
                                            .setFontSize(30)
                                            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                            .setColor(1,1,1));
            }
            for(var i = 1; i <= 4 * math.ceil(me.speed_tape_visible/10); i = i + 1){
                append(me.speedbars_minor, me.vsi_group.createChild("path","speedbarminor" ~ i)
                                            .line(-30,0)
                                            .setStrokeLineWidth(2)
                                            .setColor(1,1,1));
            }
            me.vsi_group.createChild("path","speedmarker")
                .moveTo(1024 - me.edge_dist,me.vert_center)
                .lineTo(1024 - me.far_edge_dist,me.vert_center)
                .setStrokeLineWidth(4)
                .setColor(0.2,1.0,0.2);

            ################
            # altitude tape stuff
            ################

            me.altitude_tape_visible = 4000; # how many feet to show at one time
            me.altitude_tape_pixel_per_100_feet = (me.lower_limit - me.upper_limit) / (me.altitude_tape_visible / 100);
            me.altitude_tape_text = [];
            me.altitudebars_major = [];
            me.altitudebars_minor = [];
            #print(me.altitude_tape_pixel_per_100_feet);
            for (var i = 1; i <= math.ceil(me.altitude_tape_visible/1000); i = i + 1){
                append(me.altitudebars_major, me.vsi_group.createChild("path","altitudebar" ~ i)
                                                .line(50,0)
                                                .setStrokeLineWidth(4)
                                                .setColor(1,1,1));
                append(me.altitude_tape_text, me.vsi_group.createChild("text","alttape_read" ~ i)
                                                .setAlignment("left-center")
                                                .setFontSize(25)
                                                .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                                .setColor(1,1,1));
            }
            for(var i = 1; i <= 4 * math.ceil(me.altitude_tape_visible/1000); i = i + 1){
                append(me.altitudebars_minor, me.vsi_group.createChild("path","altitudebarminor" ~ i)
                                                .line(30,0)
                                                .setStrokeLineWidth(2)
                                                .setColor(1,1,1));
            }
            me.vsi_group.createChild("path","altmarker")
                .moveTo(me.edge_dist,me.vert_center)
                .lineTo(me.far_edge_dist,me.vert_center)
                .setStrokeLineWidth(4)
                .setColor(0.2,1.0,0.2);

            ################
            # horizon circle
            ################
            
            me.hor_indicator_max = 30; # in degrees
            me.hor_indicator_radius = 200;
            me.hor_y_center = me.vert_center;
            me.hor_x_center = 1024 / 2;
            me.hor_indicator_pixels_per_degree = me.hor_indicator_radius / me.hor_indicator_max;
            me.upper_horizon = me.vsi_group.createChild("path","upper_horizon").setColorFill(0.2,0.2,1.0).setTranslation(me.hor_x_center,me.hor_y_center);
            me.lower_horizon = me.vsi_group.createChild("path","lower_horizon").setColorFill(1.0,0.5,0.0).setTranslation(me.hor_x_center,me.hor_y_center);
            me.nose_indicator = me.vsi_group.createChild("path","nose_indicator")
                                    .move(-40,0)
                                    .line(20,0)
                                    .line(10,10)
                                    .line(10,-10)
                                    .line(10,10)
                                    .line(10,-10)
                                    .line(20,0)
                                    .setTranslation(me.hor_x_center,me.hor_y_center)
                                    .setStrokeLineWidth(6)
                                    .setColor(1,1,1);
            me.pitchbars = [];
            me.pitchbars_text = [];
            me.pitchbar_group = me.mfd.createGroup();
            for (var i = 0; i <= math.ceil(me.hor_indicator_max / 10) + 2; i = i + 1){
                append(me.pitchbars, me.pitchbar_group.createChild("path","pitchbars" ~ i)
                                        .move(-80,0)
                                        .line(50,0)
                                        .move(60,0)
                                        .line(50,0)
                                        .setStrokeLineWidth(5)
                                        .setColor(1,1,1));
                append(me.pitchbars_text, me.pitchbar_group.createChild("text","pitch" ~ i)
                                        .setAlignment("center-center")
                                        .setFontSize(28)
                                        .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                        .setColor(1,1,1));
            }
            me.pitchbar_group.setTranslation(me.hor_x_center, me.hor_y_center);

            # text boxes
            me.vsi_alt_text = me.vsi_group.createChild("text","alt_disp")
                                    .setAlignment("left-top")
                                    .setFontSize(28)
                                    .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                    .setColor(1,1,1)
                                    .setTranslation(me.edge_dist,me.lower_limit+15);
            me.vsi_vss_text = me.vsi_group.createChild("text","spd_disp")
                                    .setAlignment("left-top")
                                    .setFontSize(28)
                                    .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                    .setColor(1,1,1)
                                    .setTranslation(me.edge_dist,me.lower_limit+50);
            me.vsi_spd_text = me.vsi_group.createChild("text","spd_disp")
                                    .setAlignment("right-top")
                                    .setFontSize(28)
                                    .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                    .setColor(1,1,1)
                                    .setTranslation(1024 - me.edge_dist,me.lower_limit+15);
            me.vsi_mch_text = me.vsi_group.createChild("text","spd_disp")
                                    .setAlignment("right-top")
                                    .setFontSize(28)
                                    .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                    .setColor(1,1,1)
                                    .setTranslation(1024 - me.edge_dist,me.lower_limit+50);

            ################
            # alpha gauge
            ################
            
            me.alpha_gauge_x = 800;
            me.alpha_gauge_y = 800;
            me.label_radius = 150;
            me.alpha_gauge_radius = 130;
            me.alpha_gauge_inner_min = 120;
            me.alpha_gauge_inner_maj = 100;
            me.alpha_gauge_degrees_per_alpha = 3; # how many degrees to move for each degree of alpha
            me.min_alpha = -5;
            me.max_alpha = 15;
            me.draw_alpha = me.min_alpha;
            me.current_deg = me.draw_alpha * me.alpha_gauge_degrees_per_alpha;

            # text pathings
            me.alpha_gauge_text = [];
            for (var i = 0; i < math.ceil((me.max_alpha - me.min_alpha) / 5) + 1; i = i + 1){
                append(me.alpha_gauge_text, me.vsi_group.createChild("text","alpha_gauge_text" ~ i)
                                            .setAlignment("right-center")
                                            .setFontSize(20)
                                            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                            .setColor(1,1,1));
            }
            me.alpha_gauge_readout = me.vsi_group.createChild("text","alphagaugereadout")
                                            .setAlignment("left-top")
                                            .setFontSize(30)
                                            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                            .setColor(1,1,1)
                                            .setTranslation(me.alpha_gauge_x + 10, me.alpha_gauge_y + 10);

            # gauge lines & adding text
            me.alpha_gauge = me.vsi_group.createChild("path","alpha_gauge")
                                    .setStrokeLineWidth(3)
                                    .setColor(1,1,1)
                                    .setTranslation(me.alpha_gauge_x,me.alpha_gauge_y);
            var label = [];
            var outer = [];
            var inner = [];
            var text_index = 0;
            for(var i = 0; i < me.max_alpha - me.min_alpha + 1; i = i + 1){
                outer = [-me.alpha_gauge_radius * math.cos(me.current_deg * D2R), -me.alpha_gauge_radius * math.sin(me.current_deg * D2R)];
                if (math.mod(me.draw_alpha,5) == 0) {
                    inner = [-me.alpha_gauge_inner_maj * math.cos(me.current_deg * D2R), -me.alpha_gauge_inner_maj * math.sin(me.current_deg * D2R)];
                    label = [-me.label_radius * math.cos(me.current_deg * D2R), -me.label_radius * math.sin(me.current_deg * D2R)];
                    me.alpha_gauge_text[text_index].setTranslation(label[0]+me.alpha_gauge_x,label[1]+me.alpha_gauge_y).setText(me.draw_alpha);
                    text_index += 1;
                } else {
                    inner = [-me.alpha_gauge_inner_min * math.cos(me.current_deg * D2R), -me.alpha_gauge_inner_min * math.sin(me.current_deg * D2R)];
                }
                me.alpha_gauge.moveTo(outer[0],outer[1]).lineTo(inner[0],inner[1]);
                me.draw_alpha += 1;
                me.current_deg = me.draw_alpha * me.alpha_gauge_degrees_per_alpha;
            }

            # gauge needle - default rest should be pointing exactly left
            me.alpha_gauge_needle_length = (me.alpha_gauge_radius + me.alpha_gauge_inner_min) / 2;
            me.alpha_gauge_needle = me.vsi_group.createChild("path","alphagaugeneedle")
                                        .line(-me.alpha_gauge_needle_length / 3    , -7)
                                        .line(-me.alpha_gauge_needle_length / 3 * 2,  7)
                                        .line( me.alpha_gauge_needle_length / 3 * 2,  7)
                                        .line( me.alpha_gauge_needle_length / 3,     -7)
                                        .setStrokeLineWidth(5)
                                        .setColor(1,1,1)
                                        .setTranslation(me.alpha_gauge_x, me.alpha_gauge_y);
                                        
            ################
            # sideslip gauge
            ################
            me.sideslip_x = 800;
            me.sideslip_y = 900;
            me.sideslip_bar_length = 250;
            me.sideslip_bar_height = 60;
            me.sideslip_indicator_size = 25;
            me.sideslip_max_deflection = 5;
            me.sideslip_text_offset = 30;
            
            me.sideslip_text_offset = me.sideslip_text_offset + me.sideslip_indicator_size;
            me.sideslip_pixels_per_degree = me.sideslip_bar_length / (me.sideslip_max_deflection * 2);
            
            me.sideslip_gauge_bar = me.vsi_group.createChild("path","sideslipgaugebar")
                                        .move(0,-me.sideslip_bar_height/2)
                                        .line(0, me.sideslip_bar_height)
                                        .move(-me.sideslip_bar_length/2,-me.sideslip_bar_height/2)
                                        .line( me.sideslip_bar_length,0)
                                        .setStrokeLineWidth(4)
                                        .setColor(1,1,1)
                                        .setTranslation(me.sideslip_x, me.sideslip_y);
            me.sideslip_gauge_indicator = me.vsi_group.createChild("path","sideslipindicator")
                                        .moveTo(me.sideslip_indicator_size,0)
                                        .lineTo(0,me.sideslip_indicator_size)
                                        .lineTo(-me.sideslip_indicator_size, 0)
                                        .lineTo(0,-me.sideslip_indicator_size)
                                        .lineTo(me.sideslip_indicator_size, 0)
                                        .setStrokeLineWidth(4)
                                        .setColor(1,1,1)
                                        .setTranslation(me.sideslip_x, me.sideslip_y);
            me.sideslip_gauge_readout = me.vsi_group.createChild("text","sideslip_gauge_readout")
                                        .setAlignment("center-bottom")
                                        .setFontSize(30)
                                        .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                                        .setColor(1,1,1);

        }
        me.vsi_group.show();
        me.pitchbar_group.show();

    },

    screen_vsi_rem: func() {
        if (me.vsi_group != nil) {
            me.vsi_group.hide();
            me.pitchbar_group.hide();
        }
    },

    screen_vsi: func() {
        #  get properties
        var speed = getprop("velocities/airspeed-kt");
        var v_speed = getprop("velocities/vertical-speed-fps");
        var mach = getprop("velocities/mach");
        var altitude = getprop("position/altitude-ft");
        var pitch = getprop("orientation/pitch-deg");
        var roll = getprop("orientation/roll-deg");
        var alpha = getprop("orientation/alpha-deg");
        var beta = getprop("orientation/side-slip-deg");


        # update text boxes
        me.vsi_alt_text.setText("ALT: " ~ math.round(altitude,10));
        me.vsi_vss_text.setText("V/S: " ~ math.round(v_speed*60,10));
        me.vsi_mch_text.setText(sprintf("MACH: %0.2f",mach));
        me.vsi_spd_text.setText("IAS: " ~ math.round(speed));
        #me.vsi_vss_text =
        # speed tape update
        #  print('running');

        # determine distance to bottom bar
        if (speed < me.speed_tape_visible / 2) {
            var c_line = me.vert_center + (speed * me.speed_tape_pixel_per_knot);
        } else {
            var c_line = (me.lower_limit - me.speed_tape_pixel_per_knot * 2) + (math.mod(speed,2) * me.speed_tape_pixel_per_knot);
        }

        # determine speed setting of the bottom bar
        if (speed < me.speed_tape_visible / 2) {
            var c_speed = 0;
        } else {
            var c_speed = (2 - math.mod((speed - me.speed_tape_visible / 2),2)) + (speed - me.speed_tape_visible / 2);
        }

        # update loop
        var i_maj = 0;
        var i_min = 0;
        for (var i = 1; i <= me.speed_tape_visible / 2; i = i + 1) {
            if (c_line < me.upper_limit) {
                break;
            }
            if (math.mod(c_speed,10) == 0) {
                # use a major
                me.speedbars_major[i_maj].setTranslation(1024 - me.edge_dist,c_line);
                if (c_line > me.upper_limit + 20 and c_line < me.lower_limit - 20) {
                    me.speed_tape_text[i_maj].setTranslation(1024 - me.edge_dist - 55,c_line).setText(c_speed).show();
                } else {
                    me.speed_tape_text[i_maj].hide();
                }
                i_maj = i_maj + 1;
            } else {
                me.speedbars_minor[i_min].setTranslation(1024 - me.edge_dist,c_line);
                i_min = i_min + 1;
            }
            c_speed = c_speed + 2;
            #print('c_line: ' ~ c_line);
            c_line = c_line - (me.speed_tape_pixel_per_knot * 2);
        }
        
        ################
        # altitude tape update
        ################
        
        # determine bottom bar location
        c_line = (me.lower_limit - me.altitude_tape_pixel_per_100_feet * 2) + (math.mod(altitude,200) * (me.altitude_tape_pixel_per_100_feet/100));
        #var c_alt = (200 - math.mod((altitude - me.altitude_tape_visible / 200),200)) + (altitude - me.altitude_tape_visible / 200);
        var c_alt = (altitude - (me.altitude_tape_visible/2-200)) - math.mod(altitude,200);
        i_maj = 0;
        i_min = 0;
        for (var i = 1; i <= me.altitude_tape_visible / 200; i = i + 1) {
            if (c_line < me.upper_limit) {
                break;
            }
            if (math.mod(c_alt,1000) == 0) {
                me.altitudebars_major[i_maj].setTranslation(me.edge_dist,c_line);
                if (c_line > me.upper_limit + 20 and c_line < me.lower_limit - 20) {
                    me.altitude_tape_text[i_maj].setTranslation(me.edge_dist + 55,c_line).setText(c_alt).show();
                } else {
                    me.altitude_tape_text[i_maj].hide();
                }
                i_maj = i_maj + 1;
            } else {
                me.altitudebars_minor[i_min].setTranslation(me.edge_dist,c_line);
                i_min = i_min + 1;
            }
            c_alt = c_alt + 200;
            c_line = c_line - (me.altitude_tape_pixel_per_100_feet * 2);
        }
        
        ################
        # horizon circle
        ################

        # calculate where to draw the upper/lower circles

        if(math.abs(pitch)<30) {
            var y_val = pitch * me.hor_indicator_pixels_per_degree;
            var x_val = -math.sqrt(me.hor_indicator_radius * me.hor_indicator_radius - y_val * y_val);
        } else {
            var y_val = math.sgn(pitch) * me.hor_indicator_radius;
            var x_val = -0.1;
        }

        # print(pitch ~ "|" ~ x_val ~ "|" ~ y_val);

        if (pitch > 0) {
            # nose is pointing up
            # more blue than brown
            me.upper_horizon.reset().move(x_val,y_val).arcLargeCW(me.hor_indicator_radius,me.hor_indicator_radius,0,x_val * -2,0).setRotation(-roll*D2R,0);
            me.lower_horizon.reset().move(x_val,y_val).arcSmallCCW(me.hor_indicator_radius,me.hor_indicator_radius,0,x_val * -2,0).setRotation(-roll*D2R,0);
        } else {
            me.upper_horizon.reset().move(x_val,y_val).arcSmallCW(me.hor_indicator_radius,me.hor_indicator_radius,0,x_val * -2,0).setRotation(-roll*D2R,0);
            me.lower_horizon.reset().move(x_val,y_val).arcLargeCCW(me.hor_indicator_radius,me.hor_indicator_radius,0,x_val * -2,0).setRotation(-roll*D2R,0);
        }

        #assumed: one pitch bar every 10 degrees

        # determine bottom bar location
        #print("bottom: " ~ (me.hor_y_center + me.hor_indicator_radius));
        c_line = (me.hor_indicator_radius - me.hor_indicator_pixels_per_degree * 10) + (math.mod(pitch,10) * (me.hor_indicator_pixels_per_degree));
        #print("c_line: " ~ c_line);
        var c_pitch = pitch - math.mod(pitch,10) - 20;
        for (var i = 0; i <= math.ceil(me.hor_indicator_max / 10) + 2; i = i + 1) {
            #if (c_line < me.upper_limit) {
            #    break;
            #}
            if (c_line < me.hor_indicator_radius - 25 and c_line > -me.hor_indicator_radius + 25){
                me.pitchbars[i].setTranslation(0,c_line).show();
                me.pitchbars_text[i].setTranslation(0,c_line).setText(c_pitch).show();
            } else {
                me.pitchbars[i].hide();
                me.pitchbars_text[i].hide();
            }
            c_pitch = c_pitch + 10;
            c_line = c_line - (me.hor_indicator_pixels_per_degree * 10);
        }
        me.pitchbar_group.setRotation(-roll*D2R,0);
        
        ################
        # alpha gauge stuff
        ################
        
        me.alpha_gauge_readout.setText(sprintf("α: %0.1f",alpha));
        if (alpha < me.min_alpha) {
            alpha = me.min_alpha;
        } elsif (alpha > me.max_alpha) {
            alpha = me.max_alpha;
        }
        me.alpha_gauge_needle.setRotation(alpha*me.alpha_gauge_degrees_per_alpha*D2R,0);
        
        
        ################
        # sideslip gauge stuff
        ################

        me.sideslip_gauge_readout.setText(sprintf("β: %0.1f",beta));
        if (math.abs(beta) > me.sideslip_max_deflection) {
            beta = math.sgn(beta) * me.sideslip_max_deflection;
        }
        me.sideslip_gauge_readout.setTranslation(me.sideslip_x + (beta * me.sideslip_pixels_per_degree),me.sideslip_y + me.sideslip_text_offset);
        me.sideslip_gauge_indicator.setTranslation(me.sideslip_x + (beta * me.sideslip_pixels_per_degree),me.sideslip_y);
            

    },

    screen_map_init: func() {

    },

};

var button_press = func(v) {
    if (button_array[v].main_func == nil) { return; }
    if (button_array[v].temp == 0) {
        if (cur_end_func != nil) {
            #print('calling the end func');
            call(cur_end_func, nil, mfd_ref);
        }
        #if (button_array[v].init_func != nil) {
        #    call(button_array[v].init_func, nil, mfd_ref );
        #}
        cur_main_func = button_array[v].main_func;
        cur_init_func = button_array[v].init_func;
        cur_end_func = button_array[v].end_func;
        if (cur_init_func != nil) {
            #print('calling the init func');
            call(cur_init_func, nil, mfd_ref);
        }
    } else if (button_array[v].temp == 1) {
        if (button_array[v].init_func != nil) {
            call(button_array[v].init_func, nil, mfd_ref);
        }
        if (button_array[v].main_func != nil) {
            call(button_array[v].main_func, nil, mfd_ref);
        }
        if (button_array[v].end_func != nil) {
            call(button_array[v].end_func, nil, mfd_ref);
        }
    }
}

var reset_button_array = func() {
    for (i = 0; i < 20; i = i + 1) {
        button_array[i] = button_null;
    }
}

var test_button_array = func() {
    for (i = 0; i < 20; i = i + 1) {
        button_array[i] = button_xxxx;
    }
}

var main_loop = func() {
    if (cur_main_func != nil) {
        call(cur_main_func, nil, mfd_ref );
    }
    settimer(main_loop,0.1);
}

mfd_ref = MFD_DISPLAY.new({"node": "mfdscreen"});

# button definitions# button stuff
var button_array = [];

var button_arch = {
    label: "",
    main_func: nil,
    init_func: nil,
    end_func:  nil,
    temp:        0,
};

# button definitions
var button_null   = {parents:[button_arch]};
var button_test   = {parents:[button_arch], label: "TEST", main_func: mfd_ref.screen_testfunc};
var button_xxxx   = {parents:[button_arch], label: "NULL"};
var button_status = {parents:[button_arch], label: "STAT", main_func: mfd_ref.screen_status, init_func: mfd_ref.screen_status_init, end_func: mfd_ref.screen_status_rem};
var button_sar    = {parents:[button_arch], label: "TSAR", main_func: mfd_ref.screen_sar,    init_func: mfd_ref.screen_sar_init,    end_func: mfd_ref.screen_sar_rem   };
var button_fuel   = {parents:[button_arch], label: "FUEL", main_func: mfd_ref.screen_fuel,   init_func: mfd_ref.screen_fuel_init,   end_func: mfd_ref.screen_fuel_rem  };
var button_vsi    = {parents:[button_arch], label: "VSI ", main_func: mfd_ref.screen_vsi,    init_func: mfd_ref.screen_vsi_init,    end_func: mfd_ref.screen_vsi_rem   };
    var button_sar_dist_dec   = {parents:[button_arch], label:"DISV", main_func: mfd_ref.screen_sar_dec_dist,    temp: 1};
    var button_sar_dist_inc   = {parents:[button_arch], label:"DISΛ", main_func: mfd_ref.screen_sar_inc_dist,    temp: 1};
    var button_sar_slew_left  = {parents:[button_arch], label:"SLW<", main_func: mfd_ref.screen_sar_slew_left,   temp: 1};
    var button_sar_slew_right = {parents:[button_arch], label:"SLW>", main_func: mfd_ref.screen_sar_slew_right,  temp: 1};
    var button_sar_slew_up    = {parents:[button_arch], label:"SLWΛ", main_func: mfd_ref.screen_sar_slew_up,     temp: 1};
    var button_sar_slew_down  = {parents:[button_arch], label:"SLWV", main_func: mfd_ref.screen_sar_slew_down,   temp: 1};
    var button_sar_slew_ctr   = {parents:[button_arch], label:"SLWC", main_func: mfd_ref.screen_sar_slew_center, temp: 1};
    var button_sar_zoom_in    = {parents:[button_arch], label:"ZM +", main_func: mfd_ref.screen_sar_zoom_in,     temp: 1};
    var button_sar_zoom_out   = {parents:[button_arch], label:"ZM -", main_func: mfd_ref.screen_sar_zoom_out,    temp: 1};
    var button_sar_gain_inc   = {parents:[button_arch], label:"GN +", main_func: mfd_ref.screen_sar_gain_inc,    temp: 1};
    var button_sar_gain_dec   = {parents:[button_arch], label:"GN -", main_func: mfd_ref.screen_sar_gain_dec,    temp: 1};
    var button_sar_pause      = {parents:[button_arch], label:"PAUS", main_func: mfd_ref.screen_sar_pause_draw,  temp: 1};

for (i = 0; i < 20; i = i + 1) {
    append(button_array, button_null);
}

var init = setlistener("/sim/signals/fdm-initialized", func() {
    removelistener(init); # only call once
    mfd_ref.screen_sar_init();
    mfd_ref.screen_sar_rem();
    mfd_ref.screen_status_init();
    cur_init_func = mfd_ref.screen_status_init;
    cur_main_func = mfd_ref.screen_status;
    cur_end_func = mfd_ref.screen_status_rem;
    main_loop();
});

