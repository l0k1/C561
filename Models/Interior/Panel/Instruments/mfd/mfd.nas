# (c) pinto 2018

# properties
var master_power_prop = props.globals.getNode("controls/electric/battery-switch"); # bool
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
        };

        # for SAR screen
        m.sar_max_dist = 50000; # meters
        m.sar_min_dist = 0;
        m.max_update_time = 0.0025;
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
        me.update_labels();
        if (me.status_texts == nil) {
            me.status_texts = me.mfd.createGroup();
            #idk what to really show here
            me.status_datum = [];
            append(me.status_datum,
                {
                    display: "SPEED: ",
                    prop: props.globals.getNode("velocities/airspeed-kt"),
                    child: me.status_texts.createChild("text", "lbl16")
                            .setTranslation(30, 30)
                            .setAlignment("left-center")
                            .setFont("LiberationFonts/LiberationMono-Regular.ttf")
                            .setFontSize(26, 1.0)
                            .setColor(1,1,1)
                });

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
        foreach(var nd; me.status_datum){
            nd.child.setText(nd.display ~ nd.prop.getValue());
        }
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
                    print(i~j);
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
        me.sar_pixels.show();
    },

    screen_sar_rem: func() {
        #print('hiding pixels?');
        if (me.sar_pixels != nil) {
            #print('hiding pixels.');
            me.sar_pixels.hide();
            me.sar_labels.hide();
        }
    },

    screen_sar: func() {
        me.sar_labels.getElementById("sar_dist_display").setText("DIST: " ~ (me.sar_max_dist/1000));
        me.sar_labels.getElementById("sar_horiz_slew_display").setText("SLW>: " ~ me.sar_slew_horiz);
        me.sar_labels.getElementById("sar_vert_slew_display").setText("SLWΛ: " ~ me.sar_slew_vert);
        me.sar_labels.getElementById("sar_zoom_display").setText("ZOOM: x" ~ me.sar_zoom);
        me.sar_labels.getElementById("sar_gain_display").setText("GAIN: " ~ me.sar_gain);
        me.sar_labels.getElementById("sar_loop_display").setText("# Loops: " ~ me.sar_loops);

        if (me.pause_draw == 0) {
            me.sar_labels.getElementById("sar_pause_display").setText("** PAUSED **");
        } else {
            me.sar_labels.getElementById("sar_pause_display").setText("");
        }

        #print('screensar');
        me.ang_px_x = me.sar_fov_x / me.sar_res_x;
        me.ang_px_y = me.sar_fov_y / me.sar_res_y;
        me.fov_x = me.sar_fov_x / 2;
        me.fov_y = me.sar_fov_y / 2;

        me.sar_min_dist = (me.sar_gain - 1) * 2500;

        #me.screen_sar_get_spread();

        if (me.sar_index_x == 0 and me.sar_index_y == 0) {
            me.sar_geo.set_latlon(geo.aircraft_position().lat(), geo.aircraft_position().lon(), geo.aircraft_position().alt());
        }

        me.testPos = geo.Coord.new();
        #print("loop");

        me.start_time = systime();
        me.sar_loops = 0;
        while (systime() - me.start_time < me.max_update_time) { 
            me.sar_loops = me.sar_loops + 1;
            if (me.pause_draw == 0) {return;}
        #for (var i = 0; i < me.sar_tests_per_loop; i = i + 1) {
            #heading = (my_heading + sar_bearing) - (sar_fov_x / 2) + (sar_index_x * ang_px_x)
            #pitch   = (my_pitch + sar_pitch)     - (sar_fov_y / 2) + (sar_index_y * ang_px_y)
            me.heading = (heading_prop.getValue() + me.sar_slew_horiz) - me.fov_x + (me.sar_index_x * me.ang_px_x);
            me.pitch = (pitch_prop.getValue() + me.sar_slew_vert) + me.fov_y - (me.sar_index_y * me.ang_px_y);
            me.testPos = geo.aircraft_position().apply_course_distance(me.heading, me.sar_max_dist);
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
        print("we did " ~ me.sar_loops ~ " loops.");
    },

                                                                        #(i * me.sar_pixel_x_size) + me.sar_border_size,
                                                                        #(j * me.sar_pixel_y_size) + me.sar_border_size,
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

    screen_map_init: func() {

    }

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
var button_status = {parents:[button_arch], label: "STAT", main_func: mfd_ref.screen_status, init_func: mfd_ref.screen_status_init, end_func: mfd_ref.screen_status_rem};
var button_sar    = {parents:[button_arch], label: "TSAR", main_func: mfd_ref.screen_sar,    init_func: mfd_ref.screen_sar_init,    end_func: mfd_ref.screen_sar_rem};
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

