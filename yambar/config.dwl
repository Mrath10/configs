# Typical laptop setup, with wifi, brightness, battery etc, for
# i3/Sway.

# For X11/i3, you'll want to replace calls to swaymsg with i3-msg, and
# the sway-xkb module with the xkb module.

# fonts we'll be re-using here and there
awesome: &awesome Font Awesome 6 Free:style=solid:pixelsize=14
awesome_brands: &awesome_brands Font Awesome 6 Brands:pixelsize=16

std_underline: &std_underline {underline: { size: 2, color: ff0000ff}}

# This is THE bar configuration
bar:
  height: 26
  location: top
  spacing: 5
  margin: 7

  # Default font
  font: Adobe Helvetica:pixelsize=12

  foreground: ffffffff
  background: 111111cc

  border:
    width: 1
    color: 999999cc
    margin: 5
    top-margin: 0

  left:
    - script:      
        path: /home/mayv/.config/yambar/dwl-tags.sh
        args: [1]
        anchors:
          - occupied: &occupied {foreground: 57bbf4ff}
          - focused: &focused {foreground: fc65b0ff}
          - default: &default {foreground: d2ccd6ff}
        content:
          - map:
              margin: 4
              conditions:
                tag_0_occupied:
                  map:
                    conditions:
                      tag_0_focused: {string: {text: "{tag_0}", <<: *focused}}
                      ~tag_0_focused: {string: {text: "{tag_0}", <<: *occupied}}
                ~tag_0_occupied:
                  map:
                    conditions:
                      tag_0_focused: {string: {text: "{tag_0}", <<: *focused}}
                      ~tag_0_focused: {string: {text: "{tag_0}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_1_occupied:
                  map:
                    conditions:
                      tag_1_focused: {string: {text: "{tag_1}", <<: *focused}}
                      ~tag_1_focused: {string: {text: "{tag_1}", <<: *occupied}}
                ~tag_1_occupied:
                  map:
                    conditions:
                      tag_1_focused: {string: {text: "{tag_1}", <<: *focused}}
                      ~tag_1_focused: {string: {text: "{tag_1}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_2_occupied:
                  map:
                    conditions:
                      tag_2_focused: {string: {text: "{tag_2}", <<: *focused}}
                      ~tag_2_focused: {string: {text: "{tag_2}", <<: *occupied}}
                ~tag_2_occupied:
                  map:
                    conditions:
                      tag_2_focused: {string: {text: "{tag_2}", <<: *focused}}
                      ~tag_2_focused: {string: {text: "{tag_2}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_3_occupied:
                  map:
                    conditions:
                      tag_3_focused: {string: {text: "{tag_3}", <<: *focused}}
                      ~tag_3_focused: {string: {text: "{tag_3}", <<: *occupied}}
                ~tag_3_occupied:
                  map:
                    conditions:
                      tag_3_focused: {string: {text: "{tag_3}", <<: *focused}}
                      ~tag_3_focused: {string: {text: "{tag_3}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_4_occupied:
                  map:
                    conditions:
                      tag_4_focused: {string: {text: "{tag_4}", <<: *focused}}
                      ~tag_4_focused: {string: {text: "{tag_4}", <<: *occupied}}
                ~tag_4_occupied:
                  map:
                    conditions:
                      tag_4_focused: {string: {text: "{tag_4}", <<: *focused}}
                      ~tag_4_focused: {string: {text: "{tag_4}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_5_occupied:
                  map:
                    conditions:
                      tag_5_focused: {string: {text: "{tag_5}", <<: *focused}}
                      ~tag_5_focused: {string: {text: "{tag_5}", <<: *occupied}}
                ~tag_5_occupied:
                  map:
                    conditions:
                      tag_5_focused: {string: {text: "{tag_5}", <<: *focused}}
                      ~tag_5_focused: {string: {text: "{tag_5}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_6_occupied:
                  map:
                    conditions:
                      tag_6_focused: {string: {text: "{tag_6}", <<: *focused}}
                      ~tag_6_focused: {string: {text: "{tag_6}", <<: *occupied}}
                ~tag_6_occupied:
                  map:
                    conditions:
                      tag_6_focused: {string: {text: "{tag_6}", <<: *focused}}
                      ~tag_6_focused: {string: {text: "{tag_6}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_7_occupied:
                  map:
                    conditions:
                      tag_7_focused: {string: {text: "{tag_7}", <<: *focused}}
                      ~tag_7_focused: {string: {text: "{tag_7}", <<: *occupied}}
                ~tag_7_occupied:
                  map:
                    conditions:
                      tag_7_focused: {string: {text: "{tag_7}", <<: *focused}}
                      ~tag_7_focused: {string: {text: "{tag_7}", <<: *default}}
          - map:
              margin: 4
              conditions:
                tag_8_occupied:
                  map:
                    conditions:
                      tag_8_focused: {string: {text: "{tag_8}", <<: *focused}}
                      ~tag_8_focused: {string: {text: "{tag_8}", <<: *occupied}}
                ~tag_8_occupied:
                  map:
                    conditions:
                      tag_8_focused: {string: {text: "{tag_8}", <<: *focused}}
                      ~tag_8_focused: {string: {text: "{tag_8}", <<: *default}}
  center:
    - label:
        content:
          string:
            text: My Center Label
  right:
    - battery:
        name: BAT0
        poll-interval: 30000
        anchors:
          discharging: &discharging
            list:
              items:
                - ramp:
                    tag: capacity
                    items:
                      - string: {text:  , foreground: ff0000ff, font: *awesome}
                      - string: {text:  , foreground: ffa600ff, font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , font: *awesome}
                      - string: {text:  , foreground: 00ff00ff, font: *awesome}
                - string: {text: "{capacity}%", left-margin: 8}
        content:
          map:
            conditions:
              state == unknown:
                <<: *discharging
              state == discharging:
                <<: *discharging
              state == charging:
                - string: {text:  , foreground: 00ff00ff, font: *awesome}
                - string: {text: "{capacity}%", left-margin: 8}
              state == full:
                - string: {text:  , foreground: 00ff00ff, font: *awesome}
                - string: {text: "{capacity}%", left-margin: 8} 
    - clock:
        time-format: "%H:%M %Z"
        content:
          - string: {text: , font: *awesome, right-margin: 6}
          - string: {text: "{date}", right-margin: 5}
          - string: {text: , font: *awesome, right-margin: 8}
          - string: {text: "{time}"}
    - label:
        content:
          string:
            on-click: systemctl poweroff
            text: 
            right-margin: 7
            font: *awesome
